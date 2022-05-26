class ConversationsController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_notifications_as_read, only: :show

  def index
    @conversations = current_user.conversations.order(created_at: :desc)
  end

  def show
    @conversation = conversation
    @message = Message.new(conversation: @conversation)
    authorize @conversation
  end

  private

  def conversation
    @conversation ||= Conversation.find(params[:id])
  end

  def mark_notifications_as_read
    conversation.notifications_as_conversation.where(recipient: current_user).unread.mark_as_read!
  end
end
