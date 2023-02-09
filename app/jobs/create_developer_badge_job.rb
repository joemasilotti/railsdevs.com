class CreateDeveloperBadgeJob < ApplicationJob
  queue_as :default

  def perform(developer_id)
    developer = Developer.find(developer_id)
    return if developer.badge

    badge = developer.build_badge
    badge.recently_active = developer.recently_active?
    badge.source_contributor = developer.source_contributor?
    badge.save!
  end
end
