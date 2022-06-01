class MessageMailer < ApplicationMailer
  default from: Rails.configuration.emails.notifications_mailbox!
  helper :messages

  def new_message
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    message = @notification.message
    @sender = message.sender.name
    @body = message.body

    mail(
      to: recipient.email,
      subject: @notification.email_subject
    )
  end

  def first_message
    @developer = params[:developer]
    mail(
      from: Rails.configuration.emails.support_mailbox,
      to: @developer.user.email,
      subject: "Tips on responding to your first message on railsdevs"
    )
  end
end
