module Admin
  module Businesses
    class FormsController < ApplicationController
      def index
        @forms = ::Businesses::BusinessForm.includes(:business).order(created_at: :desc)
      end

      def show
        @form = ::Businesses::BusinessForm.find(params[:id])
      end
    end
  end
end
