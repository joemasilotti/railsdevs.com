module Admin
  class FeaturesController < ApplicationController
    def create
      Developer.find(params[:developer_id]).feature!
      redirect_to developers_path, notice: t(".created")
    end
  end
end
