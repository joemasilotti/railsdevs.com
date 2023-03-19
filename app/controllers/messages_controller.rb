class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_subscription!

  def create
    @message = Message.new(message_params.merge(conversation:, sender:))
    authorize @message

    if @message.save_and_notify
      unarchive_conversation
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
    if conversation.business?(current_user) && !current_user.permissions.active_subscription?
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

  def unarchive_conversation
    conversation.update(business_archived_at: nil) if conversation.business_archived_at.present?
    conversation.update(developer_archived_at: nil) if conversation.developer_archived_at.present?
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
