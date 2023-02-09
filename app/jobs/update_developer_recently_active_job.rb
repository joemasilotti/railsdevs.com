class UpdateDeveloperRecentlyActiveJob < ApplicationJob
  queue_as :default

  def perform(developer_id, recently_active)
    developer = Developer.find(developer_id)

    developer.badge.update!(recently_active:)
  end
end
