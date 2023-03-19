class ArchivedConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = load_archived
  end

  def update
    @conversation ||= Conversation.find(params[:id])

    # update the unarchived conversation to archive of a user type
    if @conversation.unarchived_by?(current_user)
      @conversation.archive_from(user_type)
      load_all
      redirect_to conversations_path
    else
      @conversation.update("#{user_type}_archived_at": nil)
      @conversations = load_archived
      redirect_to archived_conversations_path
    end
  end

  private

  def load_all
    @conversations = current_user.conversations.send("unarchived_by_#{user_type}")
    @archived_any = current_user.conversations.send("archived_by_#{user_type}").exists?
  end

  def load_archived
    current_user.conversations.send("archived_by_#{user_type}")
  end

  def user_type
    current_user.business ? "business" : "developer"
  end
end
