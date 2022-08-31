module Businesses
  class UpgradeAccountComponent < ApplicationComponent
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def render_content?
      Businesses::Permission.new(user.payment_processor).active_subscription?
    end
  end
end
