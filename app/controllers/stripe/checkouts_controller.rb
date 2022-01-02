module Stripe
  class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def show
      redirect_to BusinessSubscriptionCheckout.new(current_user).url
    end
  end
end
