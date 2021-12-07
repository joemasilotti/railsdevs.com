class ConversationPolicy < ApplicationPolicy
  def show?
    user.business == record.business || user.developer == record.developer
  end
end
