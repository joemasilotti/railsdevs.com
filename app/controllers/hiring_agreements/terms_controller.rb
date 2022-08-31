module HiringAgreements
  class TermsController < ApplicationController
    before_action :require_active_hiring_agreement!

    def show
      @term = Term.active
      @signature = Term.active.signatures.find_by(user: current_user)
    end

    private

    def require_active_hiring_agreement!
      redirect_to root_path unless Term.active?
    end
  end
end
