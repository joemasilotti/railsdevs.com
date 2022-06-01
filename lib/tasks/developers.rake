namespace :developers do
  desc "Find and notify stale developer profiles"
  task notify_stale_profiles: :environment do
    stale_developers = StaleDevelopersQuery.new.stale_and_not_recently_notified
    stale_developers.each(&:notify_as_stale)

    Rails.logger.info "Notifying #{stale_developers.count} developer(s) about their stale profile"
  end
end
