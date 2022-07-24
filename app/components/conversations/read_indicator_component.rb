module Conversations
  class ReadIndicatorComponent < ApplicationComponent
    def initialize(user, conversation:)
      @user = user
      @conversation = conversation
    end

    def render?
      @conversation.latest_message&.sender?(@user) || @user.admin?
    end

    def show_read?
      @conversation.latest_message_read_by_other_recipient?(@user)
    end
  end
end
