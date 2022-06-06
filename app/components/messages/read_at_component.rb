module Messages
  class ReadAtComponent < ApplicationComponent
    def initialize(message:)
      @message = message
    end

    def render_content?
      return false unless @message.last_message_in_conversation?

      @message.read_at.present?
    end
  end
end
