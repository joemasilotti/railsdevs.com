class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
    authorize @conversation, policy_class: MessagingPolicy

    if Feature.enabled?(:notifications)
      @unread_notifications = current_user.conversation_notifications(@conversation)
      if @unread_notifications.any?
        @unread_notifications.each { |n| n.mark_as_read! }
        redirect_to conversation_path(@conversation)
      end
    end
  end
end
