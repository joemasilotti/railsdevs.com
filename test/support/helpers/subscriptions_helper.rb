module SubscriptionsHelper
  def update_subscription(subscription_identifier)
    processor_plan = Rails.configuration.subscriptions.dig(subscription_identifier, :stripe_price_id)
    pay_subscriptions(:full_time).update!(processor_plan:)
  end
end
