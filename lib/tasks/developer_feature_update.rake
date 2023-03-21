namespace :developers do
  desc "Find and notify developer on new feature updates"
  task notify_product_feature_update: :environment do
    developers = Developer.actively_looking_or_open.visible.product_feature_notifications
    developers.each(&:notify_product_feature_update)

    Rails.logger.info "Notifying #{developers.count} developer(s) about new product features"
  end
end
