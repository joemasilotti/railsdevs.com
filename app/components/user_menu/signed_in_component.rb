class UserMenu::SignedInComponent < ApplicationComponent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def business?
    user.business&.persisted?
  end
end
