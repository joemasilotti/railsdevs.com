class MessageMailer < ApplicationMailer
  def new_message
    @message = params[:message]
    @sender = @message.sender
    mail(to: @message.recipient.user.email, subject: "#{@sender.name} sent you a message on railsdevs")
  end
end
