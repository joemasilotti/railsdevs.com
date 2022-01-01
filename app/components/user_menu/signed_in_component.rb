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

  def customer?
    user.payment_processor.present?
  end

  def admin?
    user.admin?
  end

  def unread_notifications?
    user.message_notifications.unread&.any?
  end
end
