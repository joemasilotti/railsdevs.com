module Businesses
  class LegacySubscriptionComponent < ApplicationComponent
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def render?
      user&.permissions&.legacy_subscription?
    end
  end
end
