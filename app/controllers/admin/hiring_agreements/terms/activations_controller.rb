module Admin
  module HiringAgreements
    module Terms
      class ActivationsController < ApplicationController
        def create
          term.activate!
          redirect_to edit_admin_hiring_agreements_term_path(term)
        end

        def destroy
          term.deactivate!
          redirect_to edit_admin_hiring_agreements_term_path(term)
        end

        private

        def term
          @term ||= ::HiringAgreements::Term.find(params[:term_id])
        end
      end
    end
  end
end
