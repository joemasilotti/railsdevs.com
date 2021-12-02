class DeveloperPolicy < ApplicationPolicy
  def update?
    user == record.user
  end
end
