class ReadNotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @read_notifications = (read_biz_notifications + read_dev_notifications).sort { |a, b| b.created_at <=> a.created_at }
  end

  def read_dev_notifications
    current_user.developer&.notifications&.read || []
  end

  def read_biz_notifications
    current_user.business&.notifications&.read || []
  end
end
