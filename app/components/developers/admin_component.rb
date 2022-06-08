module Developers
  class AdminComponent < ApplicationComponent
    private attr_reader :developer, :user

    def initialize(developer, user:)
      @developer = developer
      @user = user
    end

    def render?
      !!@user&.admin?
    end
  end
end
