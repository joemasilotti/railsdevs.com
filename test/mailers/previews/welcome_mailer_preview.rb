# Preview all emails at http://localhost:3000/rails/mailers/welcome_mailer
class WelcomeMailerPreview < ActionMailer::Preview

  def welcome
    @developer = Developer.first
    notification = Notification.where(type: NewDeveloperNotification.to_s).first
    WelcomeMailer.with(record: notification, recipient: @developer.user.email).welcome_email
  end


end
