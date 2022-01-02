class MessageMailer < ApplicationMailer
  def new_message
    @notification = params[:record]
    instance = @notification.to_notification
    email = instance.message.recipient.user.email
    @sender = instance.message.sender.name
    mail(to: email, subject: "#{@sender} sent you a message on railsdevs")
  end
end
