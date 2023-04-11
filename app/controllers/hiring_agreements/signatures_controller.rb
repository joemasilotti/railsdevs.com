module HiringAgreements
  class SignaturesController < ApplicationController
    include Docusign::Sessionable

    before_action :authenticate_user!
    before_action :require_new_signature!
    before_action :require_docusign_signature_success_callback!, only: :create
    after_action :clear_ds_session, only: :create

    def new
      @signature = Signature.new(term: Term.active, user: current_user)
    end

    def create
      @signature = Signature.new(agreement: true, term: Term.active, user: current_user)

      if @signature.save
        redirect_to (stored_location || pricing_path), notice: t(".created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def require_docusign_signature_success_callback!
      unless cookies[:ds_pending_envelope_id] &&
          params[:envelope_id] == decrypted_envelope_id(cookies[:ds_pending_envelope_id]) &&
          params[:event] == "signing_complete"

        clear_ds_session
        flash[:alert] = "In order to continue, you must sign the Hiring Agreement."
        redirect_to new_hiring_agreement_signature_path
      end
    end

    def require_new_signature!
      redirect_to root_path if HiringAgreements::Term.signed_by?(current_user)
    end
  end
end
