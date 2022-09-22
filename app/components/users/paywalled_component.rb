module Users
  class PaywalledComponent < ApplicationComponent
    def initialize(user:, paywalled:, size: nil, title: nil, description: nil, public_key: nil)
      @user = user
      @paywalled = paywalled
      @size = size
      @title = title
      @description = description
      @public_key = public_key
    end

    def render_content?
      customer? || owner? || valid_public_profile_access?
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
      @user&.permissions&.active_subscription?
    end

    def owner?
      @paywalled&.user == @user && @user.present?
    end

    def valid_public_profile_access?
      @paywalled&.valid_public_profile_access?(@paywalled, @public_key)
    end
  end
end
