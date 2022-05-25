module Messaging
  class Message
    private attr_reader :user, :developer_id

    def initialize(user, developer_id:)
      @user = user
      @developer_id = developer_id
    end

    def build_message
      result = Permission.new(user:, business:, conversation:).validate

      if result.success?
        message = ::Message.new(conversation:)
        cold_message = ColdMessage.new(message, user:)
        Success.new(conversation:, cold_message:)
      else
        result
      end
    end

    def send_message(options)
      result = Permission.new(user:, business:, conversation:).validate

      if result.success?
        create_message(options, conversation:)
      else
        result
      end
    end

    private

    def developer
      @developer ||= Developer.visible.find(developer_id)
    end

    def business
      user.business
    end

    def conversation
      @conversation ||= Conversation.find_or_initialize_by(developer:, business:)
    end

    def create_message(options, conversation:)
      message = ::Message.new(options.merge(conversation:, sender: business))
      cold_message = ColdMessage.new(message, user:)

      if message.save
        send_notifications(message)
        Success.new(conversation:, cold_message:)
      else
        Failure.new(cold_message)
      end
    end

    def send_notifications(message)
      NewMessageNotification.with(message:, conversation:).deliver_later(developer.user)
      NewConversationNotification.with(conversation:).deliver_later(User.admin)
    end

    Success = Struct.new(:conversation, :cold_message, keyword_init: true) do
      include ResultType
      define_type :success
    end

    Failure = Struct.new(:cold_message) do
      include ResultType
      define_type :failure
    end
  end
end
