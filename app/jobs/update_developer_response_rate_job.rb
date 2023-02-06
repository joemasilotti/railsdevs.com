class UpdateDeveloperResponseRateJob < ApplicationJob
  queue_as :default

  ALLOWED_RESPONSE_TIME = Rails.application.config.developer_response_time_allowed

  def perform(developer)
    conversations = developer.conversations.where("created_at < ?", ALLOWED_RESPONSE_TIME.ago)
    replied_rate = Stats::Conversation.new(conversations).replied_rate
    developer.update_column(:response_rate, (replied_rate * 100).round.floor(-1))
  end
end
