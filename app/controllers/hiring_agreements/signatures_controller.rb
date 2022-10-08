module HiringAgreements
  class SignaturesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_new_signature!

    def new
      @signature = Signature.new(term: Term.active)
    end

    def create
      @signature = Signature.new(signature_params.merge(term: Term.active, user: current_user))

      if @signature.save
        redirect_to (stored_location || pricing_path), notice: t(".created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def require_new_signature!
      redirect_to root_path if current_user.signed_hiring_agreement?
    end

    def signature_params
      params.require(:hiring_agreements_signature).permit(:agreement)
    end
  end
end
