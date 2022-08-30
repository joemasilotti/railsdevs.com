module Admin
  module HiringAgreements
    module Terms
      class ActivationsController < ApplicationController
        def create
          term = ::HiringAgreements::Term.find(params[:term_id])
          term.activate!
          redirect_to edit_admin_hiring_agreements_term_path(term)
        end

        def destroy
          term = ::HiringAgreements::Term.find(params[:term_id])
          term.deactivate!
          redirect_to edit_admin_hiring_agreements_term_path(term)
        end
      end
    end
  end
end
