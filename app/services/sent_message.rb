class SentMessage
  Result = Struct.new(:success?, :message)

  private attr_reader :options, :user, :conversation, :sender

  def initialize(options, user:, conversation:, sender:)
    @options = options
    @user = user
    @conversation = conversation
    @sender = sender
  end

  def create
    message = Message.new(options.merge(conversation:, sender:))
    Pundit.authorize(user, message, :create?, policy_class: MessagingPolicy)
    Pundit.authorize(user, message, :messageable?, policy_class: SubscriptionPolicy)

    if message.save
      send_recipient_notification(message)
      Result.new(true, message)
    else
      Result.new(false, message)
    end
  end

  private

  def send_recipient_notification(message)
    NewMessageNotification.with(message:, conversation:).deliver_later(message.recipient.user)
  end
end
