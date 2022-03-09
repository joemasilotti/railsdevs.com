class LegacyBusinessSubscriptionComponent < ApplicationComponent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def render?
    user&.active_legacy_business_subscription?
  end
end
