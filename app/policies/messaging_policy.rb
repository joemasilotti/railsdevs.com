class MessagingPolicy < ApplicationPolicy
  def show?
    create?
  end

  def create?
    user.business == record.business || user.developer == record.developer
  end
end
