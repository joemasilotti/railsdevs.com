module SubscriptionsHelper
  def update_subscription(identifier)
    processor_plan = Businesses::Plan.with_identifier(identifier).stripe_price_id
    pay_subscriptions(:full_time).update!(processor_plan:)
  end
end
