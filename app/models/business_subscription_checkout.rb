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
      success_url:
    )
  end

  def business_subscription_price_id
    Rails.application.credentials.stripe[:price_id]
  end

  def success_url
    if developer.present?
      new_developer_message_url(developer)
    elsif user.business.present?
      conversations_url
    else
      new_business_url
    end
  end
end
