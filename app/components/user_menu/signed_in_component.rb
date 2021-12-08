class UserMenu::SignedInComponent < ApplicationComponent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def neither?
    !business? && !developer?
  end

  def business?
    user.business&.persisted?
  end

  def developer?
    user.developer&.persisted?
  end

  def conversations?
    (user.conversations.any? || business?) && Feature.enabled?(:messaging)
  end
end
