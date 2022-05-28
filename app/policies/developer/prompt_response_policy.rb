module Developer
  class PromptResponse < ApplicationPolicy
    def create?
      record_owner?
    end

    def update?
      record_owner?
    end

    def destroy?
      record_owner?
    end

    private

    def record_owner?
      user.developer == record.developer
    end
  end
end
