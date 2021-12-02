class ConversationPolicy < ApplicationPolicy
  def show?
    user.business == record.business
  end
end
