class MessageMailer < ApplicationMailer
  default from: Rails.configuration.notifications_email
  helper :messages

  def new_message
    @notification = params[:record]
    recipient = params[:recipient]

    message = @notification.to_notification.message
    @sender = message.sender.name
    @body = message.body

    mail(to: recipient.email, subject: "#{@sender} sent you a message on railsdevs")
  end
end
