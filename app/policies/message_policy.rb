class MessagePolicy < ApplicationPolicy
  def create?
    conversation.recipient?(user.developer) ||
      permission.can_message_developer?(role_type: conversation.developer.role_type)
  end

  private

  delegate :conversation, to: :record

  def permission
    Businesses::Permission.new(user.subscriptions)
  end
end
