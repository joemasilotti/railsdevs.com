class Developers::NotificationsController < ApplicationController
  before_action :authenticate_user!, only: %i[show update]

  def show
    @developer = Developer.find(params[:developer_id])
    authorize @developer
  end

  def update
    @developer = Developer.find(params[:developer_id])
    authorize @developer

    @developer.update!(developer_params)
    redirect_to [@developer, :notifications], notice: t(".updated")
  end

  private

  def developer_params
    params.require(:developer).permit(:send_stale_notification)
  end
end
