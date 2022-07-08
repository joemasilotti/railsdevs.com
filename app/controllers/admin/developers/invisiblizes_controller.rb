module Admin
  module Developers
    class InvisiblizesController < ApplicationController
      def create
        Developer.find(params[:developer_id]).invisiblize_and_notify!
        redirect_to developers_path, notice: t(".created")
      end
    end
  end
end
