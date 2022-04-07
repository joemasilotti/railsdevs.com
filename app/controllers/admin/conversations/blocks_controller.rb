module Admin
  module Conversations
    class BlocksController < ApplicationController
      def index
        @conversations = Conversation.blocked
      end
    end
  end
end
