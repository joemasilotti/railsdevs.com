class HomeController < ApplicationController
  def show
    @developers = Developer
      .visible
      .includes(:role_type).with_attached_avatar
      .actively_looking.newest_first
      .limit(10)
  end
end
