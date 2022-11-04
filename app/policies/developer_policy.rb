class DeveloperPolicy < ApplicationPolicy
  def update?
    record_owner?
  end

  def show?
    record.visible? || record_owner? || admin?
  end

  def share_profile?
    record_owner?
  end
end
