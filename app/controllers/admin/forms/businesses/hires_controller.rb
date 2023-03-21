module Admin
  module Forms
    module Businesses
      class HiresController < ApplicationController
        def index
          @forms = ::Forms::Businesses::Hire.includes(:business).order(created_at: :desc)
        end

        def show
          @form = ::Forms::Businesses::Hire.find(params[:id])
        end
      end
    end
  end
end
