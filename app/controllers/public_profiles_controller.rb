class PublicProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @developer = developer
    authorize @developer, :share_profile?
  end

  private

  def developer
    Developers::Finder.new(id: params[:developer_id]).developer
  end
end
