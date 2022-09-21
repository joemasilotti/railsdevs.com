module Developers
  class NewFieldsComponent < ApplicationComponent
    include ComponentWithIcon

    attr_reader :user

    def initialize(user)
      @user = user
    end

    def render?
      editing? && missing_fields?
    end

    private

    def editing?
      user&.developer&.persisted?
    end

    def missing_fields?
      user.developer.missing_fields?
    end
  end
end
