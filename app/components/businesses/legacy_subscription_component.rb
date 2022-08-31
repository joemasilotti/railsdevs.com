module Businesses
  class LegacySubscriptionComponent < ApplicationComponent
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def render?
      Businesses::Permission.new(user&.payment_processor).legacy_subscription?
    end
  end
end
