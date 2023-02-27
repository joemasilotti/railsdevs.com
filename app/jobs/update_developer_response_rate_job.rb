class UpdateDeveloperResponseRateJob < ApplicationJob
  queue_as :default

  GRACE_PERIOD = Rails.application.config.developer_response_grace_period

  def perform(developer)
    conversations = developer.conversations.where("created_at < ?", GRACE_PERIOD.ago)
    replied_rate = Stats::Conversation.new(conversations).replied_rate
    developer.update_column(:response_rate, (replied_rate * 100).round)
  end
end
