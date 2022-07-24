module RevenueCat
  class Sync
    private attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def sync_subscriptions
      subscriber.entitlements.each do |entitlement|
        user.set_payment_processor(:fake_processor, allow_fake: true)
        create_or_update_subscription(entitlement)
      end
    end

    private

    def user
      @user ||= User.find(user_id)
    end

    def subscriber
      @subscriber_info ||= Tarpon::Client.subscriber(user.id).get_or_create.subscriber
    end

    def create_or_update_subscription(entitlement)
      plan = plan_for_entitlement(entitlement)
      existing_subscription = find_existing_subscription(plan)

      if existing_subscription
        existing_subscription.update!(ends_at: entitlement.expires_date)
      else
        user.payment_processor.subscribe(
          plan: plan.revenue_cat_product_identifier,
          ends_at: entitlement.expires_date
        )
      end
    end

    def plan_for_entitlement(entitlement)
      Businesses::Plan.with_processor_plan(entitlement.raw[:product_identifier])
    end

    def find_existing_subscription(subscription)
      user.payment_processor.subscriptions
        .find_by(processor_plan: subscription.revenue_cat_product_identifier)
    end
  end
end
