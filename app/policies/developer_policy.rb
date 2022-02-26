class DeveloperPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def show?
    profile_owner? || record.visible?
  end

  private

  def invisible?
    record.try(:invisible?)
  end

  def profile_owner?
    user && user.developer == record
  end
end
