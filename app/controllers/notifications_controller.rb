class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.message_notifications.unread
    @has_unread_notifications = current_user.message_notifications.unread&.any?
    @has_read_notifications = current_user.message_notifications.read&.any?
  end
end
