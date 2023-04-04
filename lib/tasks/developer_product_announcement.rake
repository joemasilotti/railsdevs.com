namespace :developers do
  desc "Announce a new feature to developers"
  task send_product_announcement: :environment do
    developers = Developer.actively_looking_or_open.visible.product_announcement_notifications
    Rails.logger.info "Notifying #{developers.count} developer(s) about new product features."
    developers.find_each(&:send_product_announcement)
  end
end
