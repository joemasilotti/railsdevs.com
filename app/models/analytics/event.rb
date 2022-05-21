module Analytics
  class Event < ApplicationRecord
    self.table_name = "analytics_events"

    validates :url, presence: true
    validates :goal, presence: true
    validates :value, presence: true, numericality: {greater_than_or_equal_to: 0}

    def tracked?
      tracked_at.present?
    end

    def track!
      touch(:tracked_at)
    end
  end
end
