class MessagesMailbox < ApplicationMailbox
  rescue_from(ActiveRecord::RecordNotFound) { bounced! }

  def process
    message = Message.new(conversation:, sender:, body:)
    if MessagePolicy.new(user, message).create?
      message.save_and_notify
      conversation.mark_notifications_as_read(user)
    else
      bounced!
    end
  end

  private

  def conversation
    @conversation ||= user.conversations.find_by!(inbound_email_token: conversation_token)
  end

  def user
    @user ||= User.find_by!(email: mail.from)
  end

  def sender
    if conversation.business?(user)
      user.business
    elsif conversation.developer?(user)
      user.developer
    end
  end

  def conversation_token
    recipient.match(/^message-(.*)@/).captures.first
  end

  def recipient
    mail.to.first
  end

  def body
    InboundEmailContent.new(mail).content
  end
end
