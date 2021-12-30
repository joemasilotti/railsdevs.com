class ReadNotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @read_notifications = current_user.message_notifications.read
  end
end
