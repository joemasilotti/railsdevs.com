module Admin
  class ConversationsController < ApplicationController
    def index
      @conversations = Conversation.blocked
    end
  end
end
