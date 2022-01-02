class MessageMailer < ApplicationMailer
  def new_message
    @notification = params[:record]
    recipient = params[:recipient]
    @sender = @notification.to_notification.message.sender.name

    mail(to: recipient.email, subject: "#{@sender} sent you a message on railsdevs")
  end
end
