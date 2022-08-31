module Users
  class PaywalledComponent < ApplicationComponent
    def initialize(user:, paywalled:, size: nil, title: nil, description: nil)
      @user = user
      @paywalled = paywalled
      @size = size
      @title = title
      @description = description
    end

    def render_content?
      customer? || owner?
    end

    def small?
      @size == :small
    end

    def large?
      @size == :large
    end

    def title
      @title || t(".title")
    end

    def description
      @description || t(".description")
    end

    private

    def customer?
      Businesses::Permission.new(@user&.payment_processor).active_subscription?
    end

    def owner?
      @paywalled&.user == @user && @user.present?
    end
  end
end
