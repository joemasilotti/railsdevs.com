module Messaging
  class ColdMessage
    attr_reader :message, :user

    def initialize(message, user:)
      @message = message
      @user = user
    end

    def messageable?
      permission.can_message_developer?(role_type: developer.role_type)
    end

    def show_hiring_fee_terms?
      permission.pays_hiring_fee?
    end

    def developer
      conversation.developer
    end

    def business
      conversation.business
    end

    private

    def conversation
      message.conversation
    end

    def permission
      Businesses::Permission.new(user.subscriptions)
    end
  end
end
