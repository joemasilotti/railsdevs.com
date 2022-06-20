module OpenStartup
  class Reporting
    def self.refresh
      metrics = new
      metrics.persist
      metrics.normalize
      metrics.calculate
      nil
    end

    def persist
      log "Fetching and persisting Stripe::BalanceTransaction records..."
      Stripe.balance_transactions.each do |transaction|
        next unless StripeTransaction.transaction_types.key?(transaction.type)
        create_or_update_transaction(transaction)
      end
    end

    def normalize
      normalize_revenue
      normalize_expenses
      normalize_contributions
      normalize_monthly_balances
    end

    def calculate
      calculate_mrr
      fetch_visitors
    end

    private

    def create_or_update_transaction(t)
      transaction = StripeTransaction.find_or_initialize_by(stripe_id: t.id)
      transaction.update!({
        amount: t.amount.fdiv(100).abs,
        created: Time.zone.at(t.created),
        description: t.description,
        fee: t.fee.fdiv(100).abs,
        transaction_type: t.type
      })
    end

    def normalize_revenue
      log "Normalizing revenue..."
      Revenue.transaction do
        Revenue.delete_all

        monthly_charges = StripeTransaction.charge
          .group_by_month(:created).group(:description)
          .sum(:amount)
        monthly_charges.each do |(occurred_on, description), amount|
          next if amount.zero?
          description = "Hiring fees" if description == "Payment for Invoice"
          Revenue.create!(occurred_on:, description: description.pluralize, amount:)
        end
      end
    end

    def normalize_expenses
      log "Normalizing expenses..."
      Expense.transaction do
        Expense.delete_all

        charge_fees = StripeTransaction.charge.group_by_month(:created).sum(:fee)
        stripe_fees = StripeTransaction.stripe_fee.group_by_month(:created).sum(:amount)
        charge_fees.each do |created, amount|
          amount += (stripe_fees[created] || 0)
          Expense.create!(occurred_on: created, description: "Stripe fees", amount:)
        end

        Transaction.expense.find_each do |transaction|
          attributes = %w[occurred_on description url amount]
          Expense.create!(transaction.attributes.slice(*attributes))
        end
      end
    end

    def normalize_contributions
      log "Normalizing contributions..."
      Contribution.transaction do
        Contribution.delete_all

        StripeTransaction.contribution.group_by_month(:created).sum(:amount).each do |month, amount|
          Contribution.create!(occurred_on: month, description: "Climate contribution", amount:)
        end

        Transaction.contribution.find_each do |transaction|
          attributes = %w[occurred_on description url amount]
          Contribution.create!(transaction.attributes.slice(*attributes))
        end
      end
    end

    def normalize_monthly_balances
      log "Normalizing monthly balances..."
      MonthlyBalance.transaction do
        MonthlyBalance.delete_all

        revenue = OpenStartup::Revenue.group_by_month(:occurred_on).sum(:amount)
        expenses = OpenStartup::Expense.group_by_month(:occurred_on).sum(:amount)
        contributions = OpenStartup::Contribution.group_by_month(:occurred_on).sum(:amount)

        months = revenue.keys | expenses.keys | contributions.keys
        months.each do |month|
          MonthlyBalance.create!(
            occurred_on: month,
            revenue: revenue[month] || 0,
            expenses: expenses[month] || 0,
            contributions: contributions[month] || 0
          )
        end
      end
    end

    def calculate_mrr
      log "Calculating MRR..."
      mrr = 0
      Stripe.subscriptions.each do |subscription|
        next if subscription.cancel_at_period_end?
        next if subscription.pause_collection.present?
        next unless subscription.status == "active"
        mrr += subscription.items.first.price.unit_amount.fdiv(100)
      end

      metric.update!(mrr: mrr.round)
    end

    def fetch_visitors
      log "Fetching visitors..."
      visitors = Visitors.fetch
      metric.update!(visitors:)
    end

    def metric
      Metric.find_or_initialize_by(occurred_on: Time.zone.today)
    end

    def log(message)
      Rails.logger.info(message)
    end
  end
end
