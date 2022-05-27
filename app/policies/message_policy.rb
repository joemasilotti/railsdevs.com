class MessagePolicy < ApplicationPolicy
  def create?
    return true if developer_recipient?

    return false unless business_recipient?

    permission.can_message_developer?(role_type: developer.role_type)
  end

  private

  def developer_recipient?
    user.developer == developer
  end

  def business_recipient?
    user.business == business
  end

  def business
    record.conversation.business
  end

  def developer
    record.conversation.developer
  end

  def permission
    Businesses::Permission.new(user.subscriptions)
  end
end
