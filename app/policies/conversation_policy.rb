class ConversationPolicy < ApplicationPolicy
  def create?
    show?
  end

  def show?
    return true if user.admin?
    return false if record.blocked?

    involved_in_conversation?
  end

  private

  def involved_in_conversation?
    business_recipient? || developer_recipient?
  end

  def business_recipient?
    user.business == record.business
  end

  def developer_recipient?
    user.developer == record.developer
  end
end
