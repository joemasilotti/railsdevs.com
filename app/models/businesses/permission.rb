module Businesses
  class Permission
    private attr_reader :subscriptions

    def initialize(subscriptions)
      @subscriptions = subscriptions || Pay::Subscription.none
    end

    def active_subscription?
      active_subscriptions.any?
    end

    def legacy_subscription?
      active_subscriptions(:legacy).any?
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

    def active_subscriptions(subscription_identifier = nil)
      return subscriptions.active unless subscription_identifier.present?

      price_id = Subscription.with_identifier(subscription_identifier).price_id
      subscriptions.active.where(processor_plan: price_id)
    end

    def full_time_subscription?
      active_subscriptions(:full_time).any?
    end

    def part_time_subscription?
      active_subscriptions(:part_time).any?
    end

    def free_subscription?
      active_subscriptions(:free).any?
    end
  end
end
