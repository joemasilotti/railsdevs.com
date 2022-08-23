class NotificationsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @notifications = pagy(current_user.notifications.visible.unread.newest_first)
    @read_notifications = current_user.notifications.visible.read
  end

  def show
    notification = current_user.notifications.visible.find(params[:id])
    notification.mark_as_read!

    if (url = notification.to_notification.url)
      redirect_to url
    else
      redirect_to notifications_path, notice: t(".notice")
    end
  end
end
