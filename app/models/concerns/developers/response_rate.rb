module Developers
  module ResponseRate
    extend ActiveSupport::Concern

    def response_rate
      replied_rate.floor(-1)
    end

    private

    def replied_rate
      (stats.replied_rate * 100).round
    end

    def stats
      @stats ||= Stats::Conversation.new(conversations)
    end
  end
end
