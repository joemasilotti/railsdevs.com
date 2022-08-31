module Businesses
  class Permission
    private attr_reader :customer

    def initialize(payment_processor)
      @customer = payment_processor || Pay::Customer.new
    end

    def active_subscription?
      subscribed?
    end

    def legacy_subscription?
      subscribed?(to: :legacy)
    end

    def pays_hiring_fee?
      full_time_subscription?
    end

    def can_message_developer?(role_type:)
      if legacy_subscription? || full_time_subscription? || free_subscription?
        true
      elsif part_time_subscription? && !role_type.only_full_time_employment?
        true
      else
        false
      end
    end

    private

    def subscribed?(to: nil)
      if (plan_identifier = to)
        processor_plans = processor_plans_for(plan_identifier)
        customer.subscriptions.where(processor_plan: processor_plans).active.exists?
      else
        customer.subscriptions.active.exists?
      end
    end

    def processor_plans_for(plan_identifier)
      Plan.with_identifier(plan_identifier).processor_plans
    end

    def full_time_subscription?
      subscribed?(to: :full_time)
    end

    def part_time_subscription?
      subscribed?(to: :part_time)
    end

    def free_subscription?
      subscribed?(to: :free)
    end
  end
end
