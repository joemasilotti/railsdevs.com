class PaywallComponent < ApplicationComponent
  def initialize(user:)
    @user = user
  end

  def customer?
    @user.active_business_subscription?
  end
end
