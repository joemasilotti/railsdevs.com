require "test_helper"

class OpenStartup::ReportingTest < ActiveSupport::TestCase
  include StripeHelper

  test "refreshes Revenue records (grouped by month and description)" do
    @balance_transactions = [
      charge(amount: 1000, created: january, description: "New subscription"),
      charge(amount: 2000, created: january, description: "New subscription"),
      charge(amount: 4000, created: february, description: "New subscription"),
      charge(amount: 5000, created: february, description: "Update subscription"),
      charge(amount: 9900, created: february, description: "Payment for Invoice")
    ]

    refresh_metrics

    revenue = OpenStartup::Revenue.pluck(:occurred_on, :description, :amount)
    assert_equal 4, revenue.count
    assert_includes revenue, [Date.new(2022, 1, 1), "New subscriptions", 30]
    assert_includes revenue, [Date.new(2022, 2, 1), "New subscriptions", 40]
    assert_includes revenue, [Date.new(2022, 2, 1), "Hiring fees", 99]
    assert_includes revenue, [Date.new(2022, 2, 1), "Update subscriptions", 50]
  end

  test "refreshes Expense records (grouped by month and merged with additional fees) and adds manual expenses" do
    @balance_transactions = [
      charge(created: january, fee: -100),
      charge(created: january, fee: -200),
      charge(created: february, fee: -400),

      fee(created: january, amount: -10),
      fee(created: january, amount: -20),
      fee(created: february, amount: -40)
    ]

    refresh_metrics

    assert_equal OpenStartup::Expense.pluck(:occurred_on, :description, :amount), [
      [Date.new(2022, 1, 1), "Stripe fees", 3.30],
      [Date.new(2022, 2, 1), "Stripe fees", 4.40],
      [Date.new(2021, 12, 30), "Expense", 9.99]
    ]
  end

  test "refreshes Contribution records (grouped by month) and adds manual expenses" do
    @balance_transactions = [
      contribution(created: january, amount: 10),
      contribution(created: january, amount: 20),
      contribution(created: february, amount: 40)
    ]

    refresh_metrics

    assert_equal OpenStartup::Contribution.pluck(:occurred_on, :description, :amount), [
      [Date.new(2022, 1, 1), "Climate contribution", 5.30], # 5.00 from stripe_transactions fixtures
      [Date.new(2022, 2, 1), "Climate contribution", 2.40], # 2.00 from stripe_transactions fixtures
      [Date.new(2022, 1, 30), "Donation", 100.00] # 100 from transactions fixtures
    ]
  end

  test "refreshes MonthlyBalance records" do
    @balance_transactions = [
      charge(amount: 1000, created: january),
      fee(created: january, amount: -10),
      contribution(created: january, amount: 10),

      charge(amount: 2000, created: february),
      fee(created: february, amount: -20),
      contribution(created: february, amount: 20)
    ]

    refresh_metrics

    assert_equal OpenStartup::MonthlyBalance.pluck(:occurred_on, :revenue, :expenses, :contributions), [
      [Date.new(2022, 1, 1), 10, 0.10, 105.10], # 100.00 from transactions and 5.00 from stripe_transactions fixtures
      [Date.new(2022, 2, 1), 20, 0.20, 2.20], # 2.00 from stripe_transactions fixtures
      [Date.new(2021, 12, 1), 0, 9.99, 0] # 9.99 from transactions fixtures
    ]
  end

  test "creates a Metric record for today with MRR and visitors" do
    @subscriptions = [
      Subscription.new(amount: 9900),
      Subscription.new(amount: 9900),
      Subscription.new(amount: 9900, cancelled: true),
      Subscription.new(amount: 9900, trialing: true),
      Subscription.new(amount: 9900, paused: true)
    ]
    @visitors = 2500

    refresh_metrics

    assert_equal OpenStartup::Metric.most_recent.data, {
      "mrr" => 198,
      "visitors" => 2500
    }
  end

  def refresh_metrics
    OpenStartup::Stripe.stub(:balance_transactions, balance_transactions) do
      OpenStartup::Stripe.stub(:subscriptions, subscriptions) do
        OpenStartup::Visitors.stub(:fetch, visitors) do
          OpenStartup::Reporting.refresh
        end
      end
    end
  end

  def balance_transactions
    @balance_transactions || []
  end

  def subscriptions
    @subscriptions || []
  end

  def visitors
    @visitors || 0
  end

  def january
    (today - 1.day).to_time(:utc).to_i
  end

  def february
    today.to_time(:utc).to_i
  end

  def today
    Date.new(2022, 2, 1)
  end

  def charge(created:, description: "A balance transaction", amount: 0, fee: 0)
    BalanceTransaction.new(amount:, created:, description:, fee:, type: "charge")
  end

  def fee(created:, description: "An additional fee", amount: 0, fee: 0)
    BalanceTransaction.new(amount:, created:, description:, fee:, type: "stripe_fee")
  end

  def contribution(created:, description: "An additional fee", amount: 0, fee: 0)
    BalanceTransaction.new(amount:, created:, description:, fee:, type: "contribution")
  end
end
