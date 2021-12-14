class BusinessPolicy < ApplicationPolicy
  def update?
    user == record.user
  end
end
