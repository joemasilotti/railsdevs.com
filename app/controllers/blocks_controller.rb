class BlocksController < ApplicationController
  before_action :authenticate_user!

  def new
    authorize conversation
    @conversation = conversation
  end

  def create
    authorize conversation
    block = conversation.blocked_by(current_user)

    redirect_to root_path, notice: t(".notice", other_recipient: block.blockee.name)
  end

  private

  def conversation
    @conversation ||= Conversation.find(params[:conversation_id])
  end
end
