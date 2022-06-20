module Analytics
  class EventComponent < ApplicationComponent
    def initialize(flash)
      @flash = flash
    end

    def render?
      event.present? && goal.present? && value.present?
    end

    def data
      {
        controller: "analytics--events",
        "analytics--events-goal-value": goal,
        "analytics--events-value-value": value
      }
    end

    private

    def goal
      event["goal"]
    end

    def value
      event["value"]
    end

    def event
      @flash[:event]
    end
  end
end
