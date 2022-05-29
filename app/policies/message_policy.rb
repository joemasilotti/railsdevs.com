class MessagePolicy < ApplicationPolicy
  def create?
    return true if developer_recipient?

    return false unless business_recipient?

    permission.can_message_developer?(role_type: conversation.developer.role_type)
  end

  private

  delegate :conversation, to: :record

  def developer_recipient?
    conversation.developer?(user)
  end

  def business_recipient?
    conversation.business?(user)
  end

  def permission
    Businesses::Permission.new(user.subscriptions)
  end
end
