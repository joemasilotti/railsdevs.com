class MessagingPolicy < ApplicationPolicy
  def show?
    create?
  end

  def create?
    associated_with_record? && !blocked?
  end

  private

  def associated_with_record?
    user.business == record.business || user.developer == record.developer
  end

  def blocked?
    !!record.try(:blocked?)
  end
end
