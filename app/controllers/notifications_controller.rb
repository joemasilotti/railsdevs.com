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

    if (url = notification.to_notification.url)
      redirect_to url
    else
      redirect_to notifications_path, notice: t(".notice")
    end
  end

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, notice: t("sessions.sign_in_hero")
    end
  end
end
