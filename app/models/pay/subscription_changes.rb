module Pay
  class SubscriptionChanges
    class UnknownSubscriptionChange < StandardError
      def initialize(changes)
        super("Unknown subscription change: #{changes}")
      end
    end

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
      else
        raise UnknownSubscriptionChange.new(subscription.previous_changes)
      end
    end

    def subscribed?
      change == :subscribed
    end
  end
end
