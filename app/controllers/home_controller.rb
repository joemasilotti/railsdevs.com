class HomeController < ApplicationController
  def show
    @developers = Developer
      .includes(:role_type).with_attached_avatar
      .available.most_recently_added
      .limit(10)
  end
end
