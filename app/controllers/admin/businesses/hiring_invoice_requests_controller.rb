module Admin
  module Businesses
    class HiringInvoiceRequestsController < ApplicationController
      def index
        @forms = ::Businesses::HiringInvoiceRequest.includes(:business).order(created_at: :desc)
      end

      def show
        @form = ::Businesses::HiringInvoiceRequest.find(params[:id])
      end
    end
  end
end
