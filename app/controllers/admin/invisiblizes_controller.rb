module Admin
  class InvisiblizesController < ApplicationController
    def create
      developer = Developer.find(params[:developer_id])
      InvisibleDeveloper.new(developer).mark
      redirect_to developers_path, notice: t(".created")
    end
  end
end
