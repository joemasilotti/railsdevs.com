class SubscriptionPolicy < ApplicationPolicy
  def messageable?
    Businesses::Permission.new(subscriptions)
      .can_message_developer?(role_type: developer.role_type)
  end

  private

  def subscriptions
    business.user.subscriptions
  end

  def business
    record.conversation.business
  end

  def developer
    record.conversation.developer
  end
end
