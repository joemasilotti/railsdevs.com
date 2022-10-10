module Businesses
  class ExpiredSubscriptionComponent < ApplicationComponent
    attr_reader :user, :business

    def initialize(user, business:)
      @user = user
      @business = business
    end

    def render_content?
      if user.business == business
        user.permissions.active_subscription?
      else
        true
      end
    end
  end
end
