module Admin
  class InvisiblizesController < ApplicationController
    def create
      developer.invisible!
      redirect_to developers_path, notice: t(".created")
    end

    private

    def developer
      @developer ||= Developer.find(params[:developer_id])
    end
  end
end
