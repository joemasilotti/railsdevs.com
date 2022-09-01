module Admin
  class ImpersonateComponent < ApplicationComponent
    attr_reader :email

    def initialize(email)
      super
      @email = email
    end
  end
end
