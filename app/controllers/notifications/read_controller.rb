class Notifications::ReadController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.message_notifications.read
  end
end
