module Analytics
  class Event < ApplicationRecord
    self.table_name = "analytics_events"

    validates :url, presence: true
    validates :goal, presence: true
    validates :value, presence: true, numericality: {greater_than_or_equal_to: 0}

    def self.added_developer_profile(url)
      Analytics::Event.create!(url:, goal: goals.added_developer_profile)
    end

    def self.added_business_profile(url)
      Analytics::Event.create!(url:, goal: goals.added_business_profile)
    end

    def self.subscribed_to_business_plan(url, value:)
      Analytics::Event.create!(url:, goal: goals.subscribed_to_business_plan, value: value * 100)
    end

    def self.goals
      Rails.configuration.analytics
    end

    def tracked?
      tracked_at.present?
    end

    def track!
      touch(:tracked_at)
    end
  end
end
