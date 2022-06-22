module Businesses
  class AdminComponent < ApplicationComponent
    private attr_reader :user
    attr_reader :business

    def initialize(business, user:)
      @business = business
      @user = user
    end

    def render?
      !!@user&.admin?
    end
  end
end
