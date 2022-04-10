module Admin
  class InvisiblizesController < ApplicationController
    def create
      Developer.find(params[:developer_id]).invisible!
      redirect_to developers_path, notice: t(".created")
    end
  end
end
