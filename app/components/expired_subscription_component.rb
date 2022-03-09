class ExpiredSubscriptionComponent < ApplicationComponent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def active_subscription?
    user.active_business_subscription?
  end
end
