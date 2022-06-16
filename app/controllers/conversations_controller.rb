class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations.order(updated_at: :desc)
  end

  def show
    @conversation = conversation
    @message = Message.new(conversation: @conversation)
    authorize @conversation
    @conversation.mark_notifications_as_read(current_user)
  end

  private

  def conversation
    @conversation ||= Conversation.find(params[:id])
  end
end
