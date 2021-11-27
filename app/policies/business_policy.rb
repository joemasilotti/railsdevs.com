class BusinessPolicy < ApplicationPolicy
  class AlreadyExists < StandardError; end

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

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
