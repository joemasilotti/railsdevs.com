module Analytics
  class EventTracking
    class UnknownGoal < StandardError; end

    private attr_reader :event_type, :url

    def initialize(event_type, url: nil, value: 0)
      @event_type = event_type
      @url = url
      @value = value
    end

    def create_event
      Analytics::Event.create!(url:, goal:, value:)
    end

    private

    def goal
      goals[event_type] || raise(UnknownGoal.new)
    end

    def goals
      Rails.configuration.analytics
    end

    def value
      @value * 100
    end
  end
end
