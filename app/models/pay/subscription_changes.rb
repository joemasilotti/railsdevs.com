module Pay
  class SubscriptionChanges
    private attr_reader :subscription

    def initialize(subscription)
      @subscription = subscription
    end

    def change
      case subscription.previous_changes
      in processor_plan: [nil, String]
        :subscribed
      in ends_at: [nil, Time]
        :churned
      in ends_at: [Time, _]
        :resubscribed
      in processor_plan: Array
        :plan_changed
      in data: [{pause_behavior: nil}, _]
        :paused
      in data: [_, {pause_behavior: nil}]
        :unpaused
      end
    end
  end
end
