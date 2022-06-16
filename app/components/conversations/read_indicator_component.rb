module Conversations
  class ReadIndicatorComponent < ApplicationComponent
    def initialize(user, conversation:)
      @user = user
      @conversation = conversation
    end

    def render?
      @conversation.latest_message&.sender?(@user)
    end

    def show_read?
      @conversation.latest_message_read_by_other_user?(other_user)
    end

    private

    def other_user
      @conversation.other_recipient(@user).user
    end
  end
end
