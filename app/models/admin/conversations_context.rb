module Admin
  class ConversationsContext
    attr_reader :entity, :title, :options

    def initialize(entity, title:, options:)
      @entity = entity
      @title = title
      @options = options
    end

    def query
      @query ||= ConversationQuery.new(entity, options)
    end

    def stats
      @stats ||= Stats::Conversation.new(query.all_records)
    end
  end
end
