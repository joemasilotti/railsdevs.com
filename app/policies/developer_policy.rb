class DeveloperPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def show?
    profile_owner? || record.try(:visible?)
  end

  private

  def visible?
    record.try(:visible?)
  end

  def profile_owner?
    user && user.developer == record
  end
end
