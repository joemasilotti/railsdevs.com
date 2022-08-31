class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_subscription!

  def create
    @message = Message.new(message_params.merge(conversation:, sender:))
    authorize @message

    if @message.save_and_notify
      respond_to do |format|
        format.turbo_stream { @new_message = conversation.messages.build }
        format.html { redirect_to conversation }
      end
    else
      render "conversations/show", status: :unprocessable_entity
    end
  end

  private

  def require_active_subscription!
    if conversation.business?(current_user) && !Businesses::Permission.new(current_user.payment_processor).active_subscription?
      redirect_to pricing_path, alert: t("errors.business_subscription_inactive")
    end
  end

  def conversation
    @conversation ||= Conversation.visible.find(params[:conversation_id])
  end

  def developer
    conversation.developer
  end

  def sender
    if conversation.business?(current_user)
      current_user.business
    elsif conversation.developer?(current_user)
      current_user.developer
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
