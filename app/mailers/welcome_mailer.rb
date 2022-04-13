class WelcomeMailer < ApplicationMailer
  default from: "joe@masilotti.com"
  helper :messages


  def welcome_email
    @notification = params[:record]
    recipient = params[:recipient]
    @developer = @notification.to_notification.developer
    mail(to: @developer.user.email, subject: "Welcome to railsdevs!")
  end
end
