Pay.setup do |config|
  config.business_name = "RailsDevs"
  config.business_address = "2625 SE Market St, Portland, OR 97214"
  config.application_name = "RailsDevs"
  config.support_email = Rails.configuration.emails.support_mailbox!

  config.default_product_name = "RailsDevs"
  config.default_plan_name = "Business subscription"

  config.automount_routes = true
  config.routes_path = "/pay"

  config.mailer = "PayMailer"

  config.emails.subscription_renewing = ->(_pay_subscription, price) {
    (price&.type == "recurring") && %w[month year].include?(price.recurring&.interval)
  }
end

Rails.application.config.to_prepare do
  Pay::Subscription.include Pay::SubscriptionExtensions
end
