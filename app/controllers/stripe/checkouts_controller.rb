module Stripe
  class CheckoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_signed_hiring_agreement!

    def create
      redirect_to BusinessSubscriptionCheckout.new(
        user: current_user,
        plan: params[:plan],
        success_path: stored_location_for(:user)
      ).url, allow_other_host: true
    end

    private

    def require_signed_hiring_agreement!
      if current_user.needs_to_sign_hiring_agreement?
        redirect_to new_hiring_agreement_signature_path, notice: I18n.t("errors.hiring_agreements.payment")
      end
    end
  end
end
