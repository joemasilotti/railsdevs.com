module Stats
  class Conversation
    private attr_reader :conversations

    def initialize(conversations)
      @conversations = conversations
    end

    def sent
      @sent ||= conversations.count
    end

    def replied
      @replied ||= Message.where(sender_type: "Developer", conversation: conversations)
        .group(:conversation_id)
        .count.count
    end

    def replied_rate
      @replied_rate ||= replied.fdiv(sent)
    end
  end
end
