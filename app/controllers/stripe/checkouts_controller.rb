module Stripe
  class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def create
      redirect_to BusinessSubscriptionCheckout.new(
        user: current_user,
        plan: params[:plan],
        success_path: stored_location_for(:user)
      ).url, allow_other_host: true
    end
  end
end
