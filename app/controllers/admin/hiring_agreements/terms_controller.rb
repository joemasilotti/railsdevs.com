module Admin
  module HiringAgreements
    class TermsController < ApplicationController
      def index
        @terms = ::HiringAgreements::Term.order(created_at: :desc)
        @active_term = ::HiringAgreements::Term.active if ::HiringAgreements::Term.active?
      end

      def new
        @term = ::HiringAgreements::Term.new
      end

      def create
        @term = ::HiringAgreements::Term.new(term_params)
        if @term.save
          redirect_to admin_hiring_agreements_term_path(@term), notice: t(".created")
        else
          render :new, status: :unprocessable_entity
        end
      end

      def show
        @term = ::HiringAgreements::Term.find(params[:id])
      end

      def edit
        @term = ::HiringAgreements::Term.find(params[:id])
      end

      def update
        @term = ::HiringAgreements::Term.find(params[:id])
        if @term.update(term_params)
          redirect_to admin_hiring_agreements_term_path(@term), notice: t(".updated")
        else
          render :edit, status: :unprocessable_entity
        end
      end

      private

      def term_params
        params.require(:hiring_agreements_term).permit(:body, :activated_at)
      end
    end
  end
end
