class DevelopersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :require_new_developer!, only: %i[new create]

  def index
    @developers_count = SignificantFigure.new(Developer.visible.count).rounded
    @query = DeveloperQuery.new(permitted_attributes([:developers, :query]))
    @meta = Developers::Meta.new(query: @query, count: @developers_count)
  end

  def new
    @developer = current_user.build_developer
  end

  def create
    @developer = current_user.build_developer(developer_params)

    if @developer.save_and_notify
      url = developer_path(@developer)
      event = Analytics::Event.added_developer_profile(url)
      redirect_to event, notice: t(".created")
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

    if @developer.update_and_notify(developer_params)
      redirect_to @developer, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @developer = Developer.find(params[:id])
    authorize @developer
  end

  private

  def pundit_params_for(_record)
    params["developer-filters-mobile"] || params
  end

  def require_new_developer!
    if current_user.developer.present?
      redirect_to edit_developer_path(current_user.developer)
    end
  end

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
      :search_query,
      :profile_reminder_notifications,
      location_attributes: [:city, :state, :country],
      role_type_attributes: RoleType::TYPES,
      role_level_attributes: RoleLevel::TYPES
    )
  end
end
