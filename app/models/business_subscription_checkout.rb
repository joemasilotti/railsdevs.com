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
      line_items: plan.price_id,
      success_url: analytics_event_url(event),
      subscription_data: {
        metadata: {
          pay_name: plan.name
        }
      }
    )
  end

  def plan
    BusinessSubscription.new(@plan)
  end

  def event
    @event ||= Analytics::Event.subscribed_to_busines_plan(success_path)
  end

  def success_path
    @success_path || developers_path
  end
end
