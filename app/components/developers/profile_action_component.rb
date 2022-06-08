module Developers
  class ProfileActionComponent < ApplicationComponent
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def update_profile?
      user&.developer
    end
  end
end
