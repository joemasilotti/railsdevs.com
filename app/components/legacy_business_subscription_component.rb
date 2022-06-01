class LegacyBusinessSubscriptionComponent < ApplicationComponent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def render?
    Businesses::Permission.new(user&.subscriptions).legacy_subscription?
  end
end
