module Stripe
  class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def index
      redirect_to BusinessSubscriptionCheckout.new(current_user).url
    end
  end
end
