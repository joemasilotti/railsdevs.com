class BusinessesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :require_new_business!, only: %i[new create]

  def new
    @business = current_user.build_business
  end

  def create
    success_url = stored_location_for(:user) || developers_path
    result = Businesses::Profile.new(current_user, success_url:)
      .create_profile(permitted_attributes(Business))

    if result.success?
      redirect_to result.event, notice: result.message
    else
      @business = result.business
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @business = Business.find(params[:id])
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
