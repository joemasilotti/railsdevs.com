class MessagePolicy < ApplicationPolicy
  def create?
    developer_recipient? ||
      permission.can_message_developer?(role_type: conversation.developer.role_type)
  end

  private

  delegate :conversation, to: :record

  def developer_recipient?
    conversation.developer?(user)
  end

  def permission
    Businesses::Permission.new(user.subscriptions)
  end
end
