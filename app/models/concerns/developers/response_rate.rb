module Developers
  module ResponseRate
    extend ActiveSupport::Concern

    GOOD_RESPONSE_RATE = 90
    PERFECT_RESPONSE_RATE = 100

    def response_rate
      case replied_rate
      when GOOD_RESPONSE_RATE...PERFECT_RESPONSE_RATE then :good
      when PERFECT_RESPONSE_RATE then :perfect
      else :null
      end
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
