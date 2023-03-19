class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations.send("unarchived_by_#{user_type}")
    @archived_any = current_user.conversations.send("archived_by_#{user_type}").exists?
  end

  def show
    @conversation ||= Conversation.find(params[:id])
    @message = Message.new(conversation: @conversation)
    authorize @conversation
    @conversation.mark_notifications_as_read(current_user)
    @conversation.archive_from(user_type) if @conversation.unarchived_by?(current_user)
  end

  private

  def user_type
    current_user.business ? "business" : "developer"
  end
end
