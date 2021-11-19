class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def index
    @conversations = policy_scope(Conversation)
  end
end
