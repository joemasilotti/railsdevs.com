class MessagesMailbox < ApplicationMailbox
  rescue_from(ActiveSupport::MessageVerifier::InvalidSignature) { bounced! }
  rescue_from(ActiveRecord::RecordNotFound) { bounced! }

  def process
    message = Message.new(conversation:, sender:, body: mail_body)
    if MessagePolicy.new(user, message).create?
      message.save_and_notify
      conversation.mark_notifications_as_read(user)
    else
      bounced!
    end
  end

  private

  def conversation
    @conversation ||= user.conversations
      .find_signed!(signed_conversation_id, purpose: :message)
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

  def signed_conversation_id
    recipient.match(/^message-(.*)@/).captures.first
  end

  def recipient
    mail.to.first
  end

  def mail_body
    if mail.multipart?
      mail.parts.first.body.decoded
    else
      mail.decoded
    end
  end
end
