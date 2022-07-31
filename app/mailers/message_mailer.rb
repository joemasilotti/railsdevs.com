class MessageMailer < ApplicationMailer
  default from: Rails.configuration.emails.notifications_mailbox!

  def new_message
    @notification = params[:record].to_notification
    @recipient = params[:recipient]

    @message = @notification.message
    @sender = @message.sender.name

    conversation_token = @message.conversation.inbound_email_token

    mail(
      to: @recipient.email,
      subject: @notification.email_subject,
      reply_to: "#{@sender} <conversation+#{conversation_token}@inbound.railsdevs.com>"
    )
  end
end
