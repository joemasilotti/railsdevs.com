module Analytics
  class Event < ApplicationRecord
    self.table_name = "analytics_events"

    validates :url, presence: true
    validates :goal, presence: true
    validates :value, presence: true, numericality: {greater_than_or_equal_to: 0}

    class << self
      include UrlHelpersWithDefaultUrlOptions

      def created_developer_profile(developer)
        url = developer_path(developer)
        Analytics::Event.create!(url:, goal: goals.added_developer_profile)
      end

      def created_business_profile(url)
        Analytics::Event.create!(url:, goal: goals.added_business_profile)
      end

      def created_business_subscription(url)
        Analytics::Event.create!(url:, goal: goals.subscribed_to_busines_plan, value: 9900)
      end

      def goals
        Rails.configuration.analytics
      end
    end

    def tracked?
      tracked_at.present?
    end

    def mark_as_tracked!
      touch(:tracked_at)
    end
  end
end
