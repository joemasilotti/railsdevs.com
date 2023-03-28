module Admin
  module Developers
    class CelebrationPackageRequestsController < ApplicationController
      def index
        @forms = ::Developers::CelebrationPackageRequest.includes(:developer).order(created_at: :desc)
      end

      def show
        @form = ::Developers::CelebrationPackageRequest.find(params[:id])
      end
    end
  end
end
