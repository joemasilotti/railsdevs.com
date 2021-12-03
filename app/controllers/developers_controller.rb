class DevelopersController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @pagy, @developers = pagy(Developer.most_recently_added.with_attached_avatar)
  end

  def new
    authorize current_user.developer, policy_class: DeveloperPolicy
    @developer = current_user.build_developer
  rescue DeveloperPolicy::AlreadyExists
    redirect_to edit_developer_path(current_user.developer)
  end

  def create
    authorize current_user.developer, policy_class: DeveloperPolicy
    @developer = current_user.build_developer(developer_params)

    if @developer.save
      NewDeveloperProfileNotification.with(developer: @developer).deliver_later(User.admin)
      redirect_to @developer, notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @developer = Developer.find(params[:id])
    authorize @developer
  end

  def update
    @developer = Developer.find(params[:id])
    authorize @developer

    if @developer.update(developer_params)
      redirect_to @developer, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @developer = Developer.find(params[:id])
  end

  private

  def developer_params
    params.require(:developer).permit(
      :name,
      :available_on,
      :hero,
      :bio,
      :website,
      :github,
      :twitter,
      :linkedin,
      :avatar,
      :cover_image,
      :search_status,
      :preferred_min_hourly_rate,
      :preferred_max_hourly_rate,
      :preferred_min_salary,
      :preferred_max_salary,
      :time_zone,
      role_type_attributes: [
        :part_time_contract,
        :full_time_contract,
        :full_time_employment
      ]
    )
  end
end
