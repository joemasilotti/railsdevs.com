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
      redirect_to hiring_agreement_terms_path if HiringAgreements::Term.signed_by?(current_user)
    end

    def signature_params
      params.require(:hiring_agreements_signature).permit(:full_name, :agreement).merge(ip_address: request.ip)
    end
  end
end
