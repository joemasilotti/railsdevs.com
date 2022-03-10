class ExpiredSubscriptionComponent < ApplicationComponent
  attr_reader :user, :business

  def initialize(user, business:)
    @user = user
    @business = business
  end

  def render_content?
    if user.business == business
      user.active_business_subscription?
    else
      true
    end
  end
end
