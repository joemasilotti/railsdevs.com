class MessagingPolicy < ApplicationPolicy
  def show?
    create? || user.admin?
  end

  def create?
    associated_with_record? && !blocked?
  end

  def new?
    priviledge_checked?
 end

  private

  def priviledge_checked?
    record.conversation.developer.role_type.full_time_employment && user.full_time? || !record.conversation.developer.role_type.full_time_employment
  end
  
  def associated_with_record?
    user.business == record.business || user.developer == record.developer
  end

  def blocked?
    !!record.try(:blocked?)
  end
end
