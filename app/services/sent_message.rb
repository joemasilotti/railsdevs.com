class SentMessage
  Result = Struct.new(:status, :message) do
    def success?
      status == :success
    end

    def unauthorized?
      status == :unauthorized
    end

    def failure
      status == :failure
    end
  end

  private attr_reader :options, :user, :conversation, :sender

  def initialize(options, user:, conversation:, sender:)
    @options = options
    @user = user
    @conversation = conversation
    @sender = sender
  end

  def create
    message = Message.new(options.merge(conversation:, sender:))
    if !authorized?(message)
      Result.new(:unauthorized, message)
    elsif message.save
      send_recipient_notification(message)
      Result.new(:success, message)
    else
      Result.new(:failure, message)
    end
  end

  private

  def authorized?(message)
    MessagingPolicy.new(user, message).create? &&
      SubscriptionPolicy.new(user, message).messageable?
  end

  def send_recipient_notification(message)
    NewMessageNotification.with(message:, conversation:).deliver_later(message.recipient.user)
  end
end
