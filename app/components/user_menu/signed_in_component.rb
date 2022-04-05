class UserMenu::SignedInComponent < ApplicationComponent
  attr_reader :user, :account

  def initialize(user, account)
    @user = user
    @account = account
  end

  def neither?
    !business? && !developer?
  end

  def business?
    account.business&.persisted?
  end

  def developer?
    account.developer&.persisted?
  end

  def conversations?
    account.conversations.any? || business?
  end

  def customer?
    account.payment_processor.present?
  end

  def admin?
    user.admin?
  end

  # TODO: Should this be user or account?
  def unread_notifications?
    user.notifications.unread.any?
  end
end
