class ColdMessage
  class BusinessBlank < StandardError; end

  class MissingSubscription < StandardError; end

  class ExistingConversation < StandardError
    attr_reader :conversation

    def initialize(conversation)
      super
      @conversation = conversation
    end
  end

  Result = Struct.new(:success?, :message)

  private attr_reader :options, :user

  def initialize(options, developer_id:, user:)
    @options = options
    @developer_id = developer_id
    @user = user
  end

  def build
    message = conversation.messages.new(options.merge(sender: business))

    if business.blank?
      raise BusinessBlank.new
    elsif conversation.persisted?
      raise ExistingConversation.new(conversation)
    elsif !active_subscription?
      raise MissingSubscription.new
    elsif !MessagingPolicy.new(user, message).create?
      raise Pundit::NotAuthorizedError.new
    end

    message
  end

  def send
    message = build

    if business.blank?
      raise BusinessBlank.new
    elsif conversation.persisted?
      raise ExistingConversation.new(conversation)
    elsif !active_subscription?
      raise MissingSubscription.new
    elsif !MessagingPolicy.new(user, message).create?
      raise Pundit::NotAuthorizedError.new
    elsif !SubscriptionPolicy.new(user, message).messageable?
      raise Pundit::NotAuthorizedError.new
    elsif message.save
      send_recipient_notification(message)
      Result.new(true, message)
    else
      Result.new(false, message)
    end
  end

  private

  def developer
    @developer ||= Developer.visible.find(@developer_id)
  end

  def business
    user.business
  end

  def conversation
    @conversation ||= Conversation.find_or_initialize_by(developer:, business:)
  end

  def active_subscription?
    user.active_business_subscription?
  end

  def send_recipient_notification(message)
    NewMessageNotification.with(message:, conversation:).deliver_later(message.recipient.user)
  end
end
