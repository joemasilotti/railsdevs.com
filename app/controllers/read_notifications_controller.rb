class ReadNotificationsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @pagy, @notifications = pagy(current_user.notifications.read.newest_first)
  end

  def create
    current_user.notifications.unread.mark_as_read!
    redirect_to notifications_path, notice: t(".notice")
  end
end
