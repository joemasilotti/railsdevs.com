class UserMenu::SignedInComponent < ApplicationComponent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def profile_path
    developer? ? helpers.edit_developer_path(user.developer) : helpers.new_developer_path
  end

  private

  def developer?
    user.developer&.persisted?
  end
end
