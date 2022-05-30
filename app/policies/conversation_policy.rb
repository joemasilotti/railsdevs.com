class ConversationPolicy < ApplicationPolicy
  def create?
    show?
  end

  def show?
    return true if user.admin?
    return false if record.blocked?

    record.participant?(user)
  end
end
