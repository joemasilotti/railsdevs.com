class DeveloperPolicy < ApplicationPolicy
  def update?
    record_owner?
  end

  def show?
    record.visible? || record_owner?
  end

  private

  def record_owner?
    user == record.user
  end
end
