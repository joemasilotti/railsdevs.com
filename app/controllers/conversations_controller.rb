class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: %i[show set_status]

  def index
    @conversations = load_conversation("unarchived")
    @archived_any = load_conversation("archived").exists?
  end

  def show
    @message = Message.new(conversation: @conversation)
    authorize @conversation
    @conversation.mark_notifications_as_read(current_user)
    archive_it if unarchived?
  end

  def archived
    @conversations = load_conversation("archived")
  end

  def set_status
    if unarchived?
      archive_it
      @conversations = load_conversation("unarchived")
      @archived_any = load_conversation("archived").exists?
      redirect_to conversations_path
    else
      unarchive_it
      @conversations = load_conversation("archived")
      redirect_to conversations_archived_path
    end
  end

  private

  def set_conversation
    @conversation ||= Conversation.find(params[:id])
  end

  def load_conversation(status)
    current_user.conversations.send("#{status}_by_#{user_type}")
  end

  def archive_it
    @conversation.touch("#{user_type}_archived_at")
  end

  def unarchive_it
    @conversation.update("#{user_type}_archived_at": nil)
  end

  def user_type
    current_user.business ? "business" : "developer"
  end

  def unarchived?
    @conversation.unarchived_by?(current_user)
  end
end
