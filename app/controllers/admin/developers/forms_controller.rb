module Admin
  module Developers
    class FormsController < ApplicationController
      def index
        @forms = ::Hired::Form.includes(:developer).order(created_at: :desc)
      end

      def show
        @form = ::Hired::Form.find(params[:id])
      end
    end
  end
end
