class InboundEmailJob < ApplicationJob
  queue_as :default

  rescue_from(ActiveRecord::RecordNotFound) {}

  private attr_reader :payload

  def perform(*args)
    @payload = args.first

    email = InboundEmail.find_or_create_by!(postmark_message_id:) do |email|
      email.payload = payload
    end

    message = Message.new(conversation:, sender:, body:)
    send_message(message, email:)
    email.save!
  end

  private

  def send_message(message, email:)
    if email.message.nil? && MessagePolicy.new(user, message).create?
      message.save_and_notify
      conversation.mark_notifications_as_read(user)
      email.update!(message:)
    end
  end

  def conversation
    @conversation ||= user.conversations.find_by_inbound_email_token!(conversation_token)
  end

  def user
    @user ||= User.find_by!(email:)
  end

  def sender
    if conversation.business?(user)
      user.business
    elsif conversation.developer?(user)
      user.developer
    end
  end

  def postmark_message_id
    payload["MessageID"]
  end

  def email
    payload.dig("FromFull", "Email")
  end

  def conversation_token
    payload["MailboxHash"]&.downcase
  end

  def body
    payload["StrippedTextReply"]
  end
end
