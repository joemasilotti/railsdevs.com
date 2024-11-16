class NotificationsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @notifications = pagy(current_user.notifications.unread.newest_first)
    @read_notifications = current_user.notifications.read
  end

  def show
    notification = current_user.notifications.find(params[:id])
    notification.mark_as_read!

    if (url = notification.to_notification.url) && url.include?("/notifications/#{notification.id}")
      redirect_to URI.join("#{request.protocol}//#{request.host_with_port}", url).to_s
    else
      redirect_to notifications_path, notice: t(".notice")
    end
  end
end
