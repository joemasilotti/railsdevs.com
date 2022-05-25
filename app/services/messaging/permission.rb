module Messaging
  class Permission
    private attr_reader :user, :business, :conversation

    def initialize(user:, business:, conversation:)
      @user = user
      @business = business
      @conversation = conversation
    end

    def validate
      if business.blank?
        MissingBusiness.new
      elsif conversation.persisted?
        ExistingConversation.new(conversation)
      elsif !active_subscription?
        InvalidSubscription.new
      else
        Success.new
      end
    end

    private

    def active_subscription?
      Businesses::Permission.new(user.subscriptions).active_subscription?
    end

    class MissingBusiness
      include ResultType
      define_type :missing_business

      def message
        I18n.t("errors.business_blank")
      end
    end

    ExistingConversation = Struct.new(:conversation) do
      include ResultType
      define_type :existing_conversation
    end

    class InvalidSubscription
      include ResultType
      define_type :invalid_subscription
    end

    class Success
      include ResultType
      define_type :success
    end
  end
end
