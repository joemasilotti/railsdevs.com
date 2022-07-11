class BusinessSubscriptionCheckout
  include UrlHelpersWithDefaultUrlOptions

  attr_reader :user

  def initialize(user:, plan: nil, success_path: nil)
    @user = user
    @plan = plan
    @success_path = success_path
  end

  def url
    checkout.url
  end

  private

  def checkout
    user.set_payment_processor(:stripe)
    user.payment_processor.checkout(
      mode: "subscription",
      line_items: plan.stripe_price_id,
      success_url: analytics_event_url(event)
    )
  end

  def plan
    Businesses::Plan.with_identifier(@plan)
  end

  def event
    @event ||= Analytics::Event.subscribed_to_busines_plan(success_path, value: plan.price)
  end

  def success_path
    @success_path || developers_path
  end
end
