class UpgradeAccountComponent < ApplicationComponent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def render_content?
    user.active_business_subscription?
  end
end
