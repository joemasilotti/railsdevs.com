module Users
  class PaywalledComponent < ApplicationComponent
    renders_one :custom_paywall

    private attr_reader :user, :resource, :public_key

    def initialize(user, resource, size: nil, title: nil, description: nil, public_key: nil)
      @user = user
      @resource = resource
      @size = size
      @title = title
      @description = description
      @public_key = public_key
    end

    def render_content?
      Users::Permission.new(user, resource, public_key:).authorized?
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
  end
end
