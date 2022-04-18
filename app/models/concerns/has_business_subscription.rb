module HasBusinessSubscription
  extend ActiveSupport::Concern

  included do
    pay_customer

    def pay_customer_name
      business&.name
    end

    def active_business_subscription?
      subscriptions.active.any?
    end

    def active_legacy_business_subscription?
      active_business_subscription_to_plan?(BusinessSubscription::Legacy.new)
    end

    def active_part_time_business_subscription?
      active_business_subscription_to_plan?(BusinessSubscription::PartTime.new)
    end

    def active_full_time_business_subscription?
      active_business_subscription_to_plan?(BusinessSubscription::FullTime.new)
    end

    private

    def active_business_subscription_to_plan?(plan)
      subscriptions.where(processor_plan: plan.plan).active.any?
    end
  end
end
