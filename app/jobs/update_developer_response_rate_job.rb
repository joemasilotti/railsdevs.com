class UpdateDeveloperResponseRateJob < ApplicationJob
  queue_as :default

  def perform(developer)
    conversations = eligable_conversations(developer)
    replied_rate = Stats::Conversation.new(conversations).replied_rate
    # TODO: (Fig) - We are using update_column to avoid changing the updated_at
    # timestamp on the developer record which would trigger the rendering of a
    # 'Recently Active' badge on the developer profile.
    # This should be changed to update! once we have implemented cacheing of the
    # badges in their own model.
    developer.update_column(:response_rate, (replied_rate * 100).round)
  end

  private

  def eligable_conversations(developer)
    grace_period = Rails.application.config.developer_response_grace_period || 0.seconds

    developer.conversations.reject do |conversation|
      conversation.created_at > grace_period.ago && !conversation.developer_replied?
    end
  end
end
