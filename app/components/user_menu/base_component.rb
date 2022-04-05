module UserMenu
  class BaseComponent < ApplicationComponent
    attr_reader :user, :account

    def initialize(user, account)
      @user = user
      @account = account
    end

    def component
      if user.present?
        UserMenu::SignedInComponent.new(user, account)
      else
        UserMenu::SignedOutComponent.new
      end
    end
  end
end
