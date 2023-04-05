namespace :developers do
  desc "Find and notify stale developer profiles"
  task clean_and_notify_stale_profiles: :environment do
    notified_developers = Developers::Custodian.clean_stale_profiles
    Rails.logger.info "Notifying #{notified_developers.count} developer(s) about their stale profile"
  end
end
