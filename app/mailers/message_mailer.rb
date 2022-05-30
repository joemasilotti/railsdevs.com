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

  def first_message
    @developer = params[:developer]
    mail(to: @developer.user.email, subject: "Tips on responding to your first message on railsdevs")
  end
end
