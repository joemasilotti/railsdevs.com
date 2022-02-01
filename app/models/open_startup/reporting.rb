module OpenStartup
  class Reporting
    def self.refresh
      metrics = new
      metrics.persist
      metrics.normalize
      nil
    end

    def persist
      transactions = Stripe::BalanceTransaction.list({limit: 100}, {api_key: reporting_api_key})
      transactions.auto_paging_each do |transaction|
        next unless StripeTransaction.transaction_types.key?(transaction.type)
        create_or_update_transaction(transaction)
      end
    end

    def normalize
      normalize_revenue
      normalize_expenses
      normalize_contributions
      normalize_balances
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
      Revenue.transaction do
        Revenue.delete_all

        StripeTransaction.charge.group_by_month(:created).group(:description).sum(:amount).each do |group, amount|
          Revenue.create!(occurred_on: group.first, description: group.last.pluralize, amount:)
        end
      end
    end

    def normalize_expenses
      Expense.transaction do
        Expense.delete_all

        charge_fees = StripeTransaction.charge.group_by_month(:created).sum(:fee)
        stripe_fees = StripeTransaction.stripe_fee.group_by_month(:created).sum(:amount)
        charge_fees.each do |created, amount|
          amount += stripe_fees[created]
          Expense.create!(occurred_on: created, description: "Stripe fees", amount:)
        end

        Transaction.expense.find_each do |transaction|
          attributes = %w[occurred_on description url amount]
          Expense.create!(transaction.attributes.slice(*attributes))
        end
      end
    end

    def normalize_contributions
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

    def normalize_balances
      MonthlyBalance.transaction do
        MonthlyBalance.delete_all

        revenue = OpenStartup::Revenue.group_by_month(:occurred_on).sum(:amount)
        expenses = OpenStartup::Expense.group_by_month(:occurred_on).sum(:amount)
        contributions = OpenStartup::Contribution.group_by_month(:occurred_on).sum(:amount)

        revenue.each do |month, amount|
          MonthlyBalance.create!(
            occurred_on: month,
            revenue: amount,
            expenses: expenses[month],
            contributions: contributions[month]
          )
        end
      end
    end

    def calculate_mrr
      subscriptions = Stripe::Subscription.list({limit: 100}, {api_key: reporting_api_key})
      mrr = 0
      subscriptions.auto_paging_each do |subscription|
        next if subscription.cancel_at_period_end?
        mrr += subscription.items.first.price.unit_amount.fdiv(100)
      end

      Metric.find_or_initialize_by({}).update!(mrr: mrr.round)
    end

    def fetch_visitors
      visitors = Visitors.fetch
      Metric.find_or_initialize_by({}).update!(visitors:)
    end

    def reporting_api_key
      Rails.application.credentials.stripe[:reporting_key]
    end
  end
end
