class ReadNotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.read
  end
end
