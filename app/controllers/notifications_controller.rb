class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.message_notifications.unread
    @read_notifications = current_user.message_notifications.read
  end

  def show
    notification = current_user.message_notifications.find(params[:id])
    notification.mark_as_read!
    redirect_to notification.to_notification.url
  end
end
