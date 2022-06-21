class BusinessesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :require_new_business!, only: %i[new create]

  def new
    @business = current_user.build_business
  end

  def create
    @business = current_user.build_business
    @business.assign_attributes(permitted_attributes(@business))

    if @business.save_and_notify
      url = stored_location_for(:user) || developers_path
      event = Analytics::Event.added_business_profile(url)
      redirect_to event, notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @business = Business.find(params[:id])
    authorize @business
  end

  def edit
    @business = Business.find(params[:id])
    authorize @business
  end

  def update
    @business = Business.find(params[:id])
    authorize @business

    if @business.update(permitted_attributes(@business))
      redirect_to developers_path, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_new_business!
    if current_user.business.present?
      redirect_to edit_business_path(current_user.business)
    end
  end
end
