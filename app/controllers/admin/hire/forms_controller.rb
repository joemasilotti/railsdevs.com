module Admin
  module Hire
    class FormsController < ApplicationController
      def index
        @forms = ::Hire::Form.includes(:business).order(created_at: :desc)
      end

      def show
        @form = ::Hire::Form.find(params[:id])
      end
    end
  end
end
