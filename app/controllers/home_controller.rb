class HomeController < ApplicationController
  def show
    @developers = Developer
      .includes(:role_type).with_attached_avatar
      .available.newest_first
      .limit(10)
  end
end
