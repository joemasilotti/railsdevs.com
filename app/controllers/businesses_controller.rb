class BusinessesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :redirect_to_edit_if_already_exists, only: %i[new create]

  def new
    @business = current_user.build_business
  end

  def create
    @business = current_user.build_business(business_params)

    if @business.save
      NewBusinessNotification.with(business: @business).deliver_later(User.admin)
      redirect_to developers_path, notice: "Your business was added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @business = Business.find(params[:id])
    authorize @business
  end

  def update
    @business = Business.find(params[:id])
    authorize @business

    if @business.update(business_params)
      redirect_to developers_path, notice: "Your business was updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def redirect_to_edit_if_already_exists
    if current_user.business.present?
      redirect_to edit_business_path(current_user.business)
    end
  end

  def business_params
    params.require(:business).permit(
      :name,
      :company,
      :avatar
    )
  end
end
