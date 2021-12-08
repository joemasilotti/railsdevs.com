class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(message_params.merge(conversation: conversation, sender: sender))
    authorize @message, policy_class: MessagingPolicy

    if @message.save
      redirect_to conversation
    else
      @conversation = conversation
      render "conversations/show", status: :unprocessable_entity
    end
  end

  private

  def conversation
    Conversation.find(params[:conversation_id])
  end

  def sender
    if conversation.business == current_user.business
      current_user.business
    elsif conversation.developer == current_user.developer
      current_user.developer
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
