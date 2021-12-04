module UserMenu
  class BaseComponent < ApplicationComponent
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def component
      if user.present?
        UserMenu::SignedInComponent.new(user)
      else
        UserMenu::SignedOutComponent.new
      end
    end
  end
end
