class BlocksController < ApplicationController
  before_action :authenticate_user!

  def new
    authorize conversation, policy_class: MessagingPolicy
    @conversation = conversation
  end

  def create
    authorize conversation, policy_class: MessagingPolicy
    conversation.touch(blocked_by_column)
    redirect_to root_path, notice: t(".notice", other_recipient: other_recipient)
  end

  private

  def conversation
    @conversation ||= Conversation.find(params[:conversation_id])
  end

  def blocked_by_column
    if conversation.business?(current_user)
      :blocked_by_business_at
    elsif conversation.developer?(current_user)
      :blocked_by_developer_at
    end
  end

  def other_recipient
    conversation.other_recipient(current_user).hero
  end
end
