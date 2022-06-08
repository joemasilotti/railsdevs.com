module Businesses
  class PrimaryActionComponent < ApplicationComponent
    attr_reader :business, :user

    def initialize(business, user:)
      @business = business
      @user = user
    end

    def owner?
      user&.business == business
    end
  end
end
