class DevelopersController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @pagy, @developers = pagy(Developer.order(created_at: :desc).with_attached_avatar)
  end

  def new
    authorize current_user.developer, policy_class: DeveloperPolicy
    @developer = current_user.build_developer
  end

  def create
    authorize current_user.developer, policy_class: DeveloperPolicy
    @developer = current_user.build_developer(developer_params)

    if @developer.save
      NewDeveloperProfileNotification.with(developer: @developer).deliver_later(User.admin)
      redirect_to @developer, notice: "Your profile was added!"
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
      redirect_to @developer, notice: "Your profile was updated!"
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
      :email,
      :available_on,
      :hero,
      :bio,
      :website,
      :github,
      :twitter,
      :linkedin,
      :avatar,
      :cover_image
    )
  end
end
