class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.message_notifications.unread
    @has_read_notifications = current_user.message_notifications.read.any?
  end

  def update
    notifications = current_user.message_notifications.unread
    @notification = Notification.find(params[:id])

    if notifications.include?(@notification)
      @notification.mark_as_read!
    end

    if @notification.conversation
      redirect_to conversation_path(@notification.conversation)
    end
  end
end
