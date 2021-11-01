class DevelopersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @developers = Developer.order(created_at: :desc).with_attached_avatar
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params.merge(user: current_user))

    if @developer.save
      redirect_to @developer, notice: "Your profile was added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @developer = Developer.find(params[:id])
  end

  def update
    @developer = Developer.find(params[:id])

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
      :avatar
    )
  end
end
