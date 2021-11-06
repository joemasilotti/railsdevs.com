class DeveloperPolicy < ApplicationPolicy
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
