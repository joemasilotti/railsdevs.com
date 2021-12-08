class ColdMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_business!
  before_action :require_new_conversation!

  def new
    @message = Message.new(conversation: conversation)
  end

  def create
    @message = Message.new(message_params.merge(conversation: conversation, sender: business))
    if @message.save
      redirect_to @message.conversation
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def require_business!
    unless business.present?
      redirect_to new_business_path, notice: I18n.t("errors.business_blank")
    end
  end

  def require_new_conversation!
    redirect_to conversation unless conversation.new_record?
  end

  def conversation
    @conversation ||= Conversation.find_or_initialize_by(developer: developer, business: business)
  end

  def developer
    @developer ||= Developer.find(params[:developer_id])
  end

  def business
    current_user.business
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
