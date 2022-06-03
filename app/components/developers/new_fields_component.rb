module Developers
  class NewFieldsComponent < ApplicationComponent
    include ComponentWithIcon

    attr_reader :user

    def initialize(user, enabled: true)
      @user = user
      @enabled = enabled
    end

    def render?
      enabled? && editing? && missing_fields?
    end

    private

    def enabled?
      !!@enabled
    end

    def editing?
      user&.developer&.persisted?
    end

    def missing_fields?
      user.developer.missing_fields?
    end
  end
end
