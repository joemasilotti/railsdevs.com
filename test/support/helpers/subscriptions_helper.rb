module SubscriptionsHelper
  def update_subscription(subscription_identifier)
    price_id = Rails.configuration.subscriptions.dig(subscription_identifier, :price_id)
    pay_subscriptions(:full_time).update!(processor_plan: price_id)
  end
end
