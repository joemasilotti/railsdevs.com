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
      @replied ||= Message.from_developer.where(conversation: conversations)
        .group(:conversation_id)
        .count.count
    end

    def replied_rate
      return 0 if sent.zero?

      @replied_rate ||= replied.fdiv(sent)
    end
  end
end
