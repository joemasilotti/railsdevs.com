class DeveloperMailer < ApplicationMailer
  helper :messages

  def invisiblize
    @notification = params[:record]
    recipient = params[:recipient]

    @developer = @notification.to_notification.developer

    mail(to: recipient.email, subject: "Your profile on railsdevs was flagged")
  end

  def stale
    @notification = params[:record]
    recipient = params[:recipient]

    @developer = @notification.to_notification.developer

    mail(
      to: recipient.email,
      subject: "Is your railsdevs profile up to date?",
      from: Rails.configuration.emails.reminders_mailbox!,
      message_stream: :broadcast
    )
  end

  def welcome_email
    @developer = params[:developer]
    mail(to: @developer.user.email, subject: "Welcome to railsdevs!")
  end
end
