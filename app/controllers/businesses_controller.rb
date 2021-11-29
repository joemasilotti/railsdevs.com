class BusinessesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    authorize current_user.business, policy_class: BusinessPolicy
    @business = current_user.build_business
  rescue BusinessPolicy::AlreadyExists
    redirect_to edit_business_path(current_user.business)
  end

  def create
    authorize current_user.business, policy_class: BusinessPolicy
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

  def business_params
    params.require(:business).permit(
      :name,
      :company,
      :avatar
    )
  end
end
