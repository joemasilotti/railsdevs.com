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

    if notification.to_notification.respond_to?(:conversation)
      conversation = notification.to_notification.conversation
      redirect_to conversation_path(conversation.id)
    elsif notification.to_notification.respond_to?(:conversation_url)
      redirect_to notification.to_notification.conversation_url
    else
      redirect_to notifications_path, notice: t(".notice")
    end
  end
end
