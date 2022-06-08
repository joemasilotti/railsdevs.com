class BlocksController < ApplicationController
  before_action :authenticate_user!

  def new
    authorize conversation
    @conversation = conversation
  end

  def create
    authorize conversation
    conversation.block_by(current_user)
    redirect_to root_path, notice: t(".notice", other_recipient:)
  end

  private

  def conversation
    @conversation ||= Conversation.find(params[:conversation_id])
  end

  def other_recipient
    conversation.other_recipient(current_user).name
  end
end
