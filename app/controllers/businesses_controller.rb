class BusinessesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    result = Businesses::Profile.new(current_user).build_profile
    if result.success?
      @business = result.business
    else
      redirect_to edit_business_path(result.business)
    end
  end

  def create
    success_url = stored_location_for(:user) || developers_path
    result = Businesses::Profile.new(current_user)
      .create_profile(success_url, permitted_attributes(Business))

    if result.success?
      redirect_to result.event, notice: result.message
    elsif result.existing_business?
      redirect_to edit_business_path(result.business)
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
end
