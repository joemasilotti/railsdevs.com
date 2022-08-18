module Admin
  class SubscriptionChangeNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :subscription_change

    param :subscription, :change

    def title
      case change
      when :subscribed
        "New subscriber: #{plan.name} plan"
      when :churned
        "Churned subscriber: #{plan.name} plan"
      when :resubscribed
        "Resubscribed subscriber: #{plan.name} plan"
      when :plan_changed
        "Subscription changed: #{plan.name} plan"
      when :paused
        "Subscription paused: #{plan.name} plan"
      when :unpaused
        "Subscription resumed: #{plan.name} plan"
      end
    end

    def subscription
      params[:subscription]
    end

    def change
      params[:change]
    end

    def plan
      ::Businesses::Plan.with_processor_plan(subscription.processor_plan)
    end
  end
end
