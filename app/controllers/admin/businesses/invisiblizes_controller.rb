module Admin
  module Businesses
    class InvisiblizesController < ApplicationController
      def create
        Business.find(params[:business_id]).invisiblize_and_notify!
        redirect_to root_path, notice: t(".created")
      end
    end
  end
end
