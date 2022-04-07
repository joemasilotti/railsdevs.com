module Admin
  class ConversationsController < ApplicationController
    include Pagy::Backend

    def index
      @stats = Stats::Conversation.new
      @pagy, @conversations = pagy(conversations)
      @replied_to_conversation_ids = replied_to_conversation_ids
    end

    private

    def conversations
      @conversations ||= Conversation.includes(:business, :developer).order(created_at: :desc)
    end

    def replied_to_conversation_ids
      Message.where(sender_type: "Developer", conversation: conversations)
        .distinct.pluck(:conversation_id)
    end
  end
end
