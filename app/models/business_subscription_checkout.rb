class BusinessSubscriptionCheckout
  include UrlHelpersWithDefaultUrlOptions

  attr_reader :user, :developer

  def initialize(user, developer: nil)
    @user = user
    @developer = developer
  end

  def url
    checkout.url
  end

  private

  def checkout
    user.set_payment_processor(:stripe)
    user.payment_processor.checkout(
      mode: "subscription",
      line_items: business_subscription_price_id,
      success_url: analytics_event_url(event)
    )
  end

  def business_subscription_price_id
    Rails.application.credentials.stripe[:price_id]
  end

  def event
    @event ||= Analytics::Event.subscribed_to_busines_plan(redirect_to)
  end

  def redirect_to
    if developer.present?
      new_developer_message_path(developer)
    elsif user.business.present?
      conversations_path
    else
      new_business_path
    end
  end
end
