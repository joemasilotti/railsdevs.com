class InboundEmailJob < ApplicationJob
  queue_as :default

  rescue_from(ActiveRecord::RecordNotFound) {}

  private attr_reader :payload

  def perform(*args)
    @payload = args.first

    email = InboundEmail.find_or_initialize_by(postmark_message_id:)
    if email.new_record?
      email.payload = payload
      message = Message.new(conversation:, sender:, body:)
      send_message(message, email:)
    end
  end

  private

  def send_message(message, email:)
    if MessagePolicy.new(user, message).create?
      message.save_and_notify
      conversation.mark_notifications_as_read(user)
      email.update!(message:)
    end
  end

  def postmark_message_id
    payload["MessageID"]
  end

  def conversation
    @conversation ||= user.conversations.find_by!(inbound_email_token: conversation_token)
  end

  def user
    @user ||= User.find_by!(email:)
  end

  def email
    payload.dig("FromFull", "Email")
  end

  def conversation_token
    payload["MailboxHash"]
  end

  def sender
    if conversation.business?(user)
      user.business
    elsif conversation.developer?(user)
      user.developer
    end
  end

  def body
    payload["StrippedTextReply"]
  end
end
