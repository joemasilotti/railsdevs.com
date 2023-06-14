class UpdateDeveloperResponseRateJob < ApplicationJob
  queue_as :default

  def perform(developer_id)
    developer = Developer.find(developer_id)
    conversations = eligable_conversations(developer)
    replied_rate = Stats::Conversation.new(conversations).replied_rate
    developer.update!(response_rate: (replied_rate * 100).round)
  end

  private

  def eligable_conversations(developer)
    grace_period = Rails.application.config.developer_response_grace_period || 0.seconds

    developer.conversations.reject do |conversation|
      conversation.created_at > grace_period.ago && !conversation.developer_replied?
    end
  end
end
