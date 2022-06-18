class DeveloperPolicy < ApplicationPolicy
  def update?
    record_owner?
  end

  def show?
    record.visible? || record_owner? || user.admin?
  end
end
