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
      legacy_plan = BusinessSubscription::Legacy.new
      subscriptions.for_name(legacy_plan.name).active.any?
    end

    def active_full_time_business_subscription?
      full_time_plan = BusinessSubscription::FullTime.new
      subscriptions.for_name(full_time_plan.name).active.any?
    end
  end
end
