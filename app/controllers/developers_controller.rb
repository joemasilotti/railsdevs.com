class DevelopersController < ApplicationController
  def index
    @developers = Developer.order(created_at: :desc)
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)

    if @developer.save
      redirect_to @developer, notice: "Your profile was added!"
    else
      render :new, status: :unprocessable_entity
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
      :twitter
    )
  end
end
