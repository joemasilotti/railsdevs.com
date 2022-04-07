module Admin
  class ConversationsController < ApplicationController
    def index
      @stat = Stats::Conversation.new
    end
  end
end
