class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = (new_biz_notifications + new_dev_notifications).sort { |a, b| b.created_at <=> a.created_at }
    @has_read_notifications = read_notifications?
  end

  def update
    notifications = (new_biz_notifications + new_dev_notifications)
    @notification = Notification.find(params[:id])

    if notifications.include?(@notification)
      @notification.mark_as_read!
    end

    redirect_to params[:redirect]
  end

  def read_notifications?
    (read_biz_notifications.size + read_dev_notifications.size) > 0
  end

  def new_dev_notifications
    current_user.developer&.notifications&.unread || []
  end

  def read_dev_notifications
    current_user.developer&.notifications&.read || []
  end

  def new_biz_notifications
    current_user.business&.notifications&.unread || []
  end

  def read_biz_notifications
    current_user.business&.notifications&.read || []
  end
end
