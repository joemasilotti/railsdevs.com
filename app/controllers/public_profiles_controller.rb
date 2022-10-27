class PublicProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @developer = developer
  end

  private

  def developer
    finder = Developers::Finder.new(id: params[:developer_id])
    finder.developer
  end
end
