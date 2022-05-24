module Messaging
  class Message
    private attr_reader :user, :developer_id

    def initialize(user, developer_id:)
      @user = user
      @developer_id = developer_id
    end

    def build_message
      return invalid_state if invalid_state.present?

      message = ::Message.new(conversation:)
      cold_message = ColdMessage.new(message, user:)
      Success.new(conversation:, cold_message:)
    end

    def send_message(options)
      return invalid_state if invalid_state.present?

      create_message(options, conversation:)
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

    def invalid_state
      return @invalid_state if defined?(@invalid_state)

      @invalid_state =
        if business.blank?
          MissingBusiness.new
        elsif conversation.persisted?
          ExistingConversation.new(conversation)
        elsif !active_subscription?
          InvalidSubscription.new
        end
    end

    def active_subscription?
      Businesses::Permission.new(user.subscriptions).active_subscription?
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

    module Result
      def success?
        false
      end

      def failure?
        false
      end

      def missing_business?
        false
      end

      def existing_conversation?
        false
      end

      def invalid_subscription?
        false
      end
    end

    Success = Struct.new(:conversation, :cold_message, keyword_init: true) do
      include Result

      def success?
        true
      end
    end

    Failure = Struct.new(:cold_message) do
      include Result

      def failure?
        true
      end
    end

    class MissingBusiness
      include Result

      def missing_business?
        true
      end

      def message
        I18n.t("errors.business_blank")
      end
    end

    ExistingConversation = Struct.new(:conversation) do
      include Result

      def existing_conversation?
        true
      end
    end

    class InvalidSubscription
      include Result

      def invalid_subscription?
        true
      end
    end
  end
end
