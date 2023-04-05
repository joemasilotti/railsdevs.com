module Developers
  class Custodian
    EARLIEST_TIME = 3.months.ago.beginning_of_day

    class << self
      def clean_stale_profiles
        stale_developers = stale_developers_query
        stale_developers.each(&:mark_as_stale_and_notify)
        stale_developers.select(&:profile_reminder_notifications?)
      end

      private

      def stale_developers_query
        Developer.actively_looking_or_open
          .where(updated_at: ..EARLIEST_TIME)
      end
    end
  end
end
