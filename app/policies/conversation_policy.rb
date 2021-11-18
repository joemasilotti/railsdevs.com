class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    def initializer(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.company?
        scope.of_company(user)
      else
        scope.of_developer(user)
      end
    end
  end
end
