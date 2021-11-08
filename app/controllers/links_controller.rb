class LinksController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to DeveloperLinkBuilder.new(link_params).url
  end

  private

  def link_params
    params.permit(:developer_id, :field)
  end
end
