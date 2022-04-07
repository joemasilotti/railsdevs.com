module Stats
  class Conversation
    def sent
      @sent ||= ::Conversation.count
    end

    def replied
      @replied ||= Message.where(sender_type: "Developer").group(:conversation_id).count.count
    end

    def replied_rate
      @replied_rate ||= replied.fdiv(sent)
    end
  end
end
