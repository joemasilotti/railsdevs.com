module Admin
  module Developers
    class InvisiblizesController < ApplicationController
      def new
        @developer = Developer.find(params[:developer_id])
      end

      def create
        developer = Developer.find(params[:developer_id])
        developer.invisiblize_and_notify!(params[:reason])
        redirect_to developers_path, notice: t(".created")
      end
    end
  end
end
