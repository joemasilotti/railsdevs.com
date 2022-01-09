module Stripe
  class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def show
      developer = Developer.find_by(id: params[:developer])
      redirect_to BusinessSubscriptionCheckout.new(current_user, developer:).url
    end
  end
end
