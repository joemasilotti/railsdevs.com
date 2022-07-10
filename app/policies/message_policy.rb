class MessagePolicy < ApplicationPolicy
  def create?
    if record.conversation.blocked?
      false
    elsif developer_sender?
      true
    elsif business_sender?
      permission.can_message_developer?(developer)
    end
  end

  private

  def developer_sender?
    user.developer == developer
  end

  def business_sender?
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
