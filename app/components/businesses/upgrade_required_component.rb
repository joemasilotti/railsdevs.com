module Businesses
  class UpgradeRequiredComponent < ApplicationComponent
    private attr_reader :user

    def initialize(user)
      @user = user
    end

    def render?
      !user.admin?
    end

    def expired?
      !permission.active_subscription?
    end

    def title
      if expired?
        t(".title.expired")
      else
        t(".title.upgrade")
      end
    end

    def body
      if expired?
        t(".body.expired")
      else
        t(".body.upgrade")
      end
    end

    def cta
      if expired?
        t(".cta.expired")
      else
        t(".cta.upgrade")
      end
    end

    private

    def permission
      Businesses::Permission.new(user.payment_processor)
    end
  end
end
