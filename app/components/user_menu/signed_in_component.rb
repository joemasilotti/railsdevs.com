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
    user.conversations.any? || business?
  end

  def admin?
    user.admin?
  end

  def unread_notifications
    unread_dev_notifications + unread_biz_notifications
  end

  def unread_dev_notifications
    user.developer&.notifications&.unread || []
  end

  def unread_biz_notifications
    user.business&.notifications&.unread || []
  end
end
