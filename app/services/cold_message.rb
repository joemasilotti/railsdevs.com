class ColdMessage
  include UrlHelpersWithDefaultUrlOptions

  Result = Struct.new(:success?, :message) do
    def redirect?
      false
    end
  end

  private attr_reader :options, :user

  def initialize(options, developer_id:, user:)
    @options = options
    @developer_id = developer_id
    @user = user
  end

  def build
    message = conversation.messages.new(options.merge(sender: business))

    if business.blank?
      RedirectResult.new(new_business_path, I18n.t("errors.business_blank"))
    elsif conversation.persisted?
      RedirectResult.new(conversation_path(conversation))
    elsif !active_subscription?
      RedirectResult.new(pricing_path, I18n.t("errors.business_subscription_inactive"))
    else
      Result.new(true, message)
    end
  end

  def send
    result = build
    return result if result.redirect?

    message = result.message

    if !SubscriptionPolicy.new(user, message).messageable?
      RedirectResult.new(pricing_path, I18n.t("errors.upgrade_required"))
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
