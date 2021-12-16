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

  def unread_notifications
    user.notifications.reject { |n| n[:read_at] > 0 }
  end

  def no_unread_notifications?
    !unread_notifications.any?
  end

  def admin?
    user.admin?
  end

  def conditional_wrapper(condition = true, options = {}, &block)
    options[:tag] ||= :div
    if condition == true
      concat content_tag(options[:tag], capture(&block), options.delete_if { |k, v| k == :tag })
    else
      concat capture(&block)
    end
  end
end
