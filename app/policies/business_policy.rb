class BusinessPolicy < ApplicationPolicy
  def new?
    raise AlreadyExists unless create?

    true
  end

  def create?
    record.nil?
  end

  def update?
    user == record.user
  end
end
