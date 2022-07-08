class DeveloperMailer < ApplicationMailer
  helper :messages

  def profile_reminder
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @developer = @notification.developer

    mail(
      to: recipient.email,
      subject: @notification.email_subject,
      from: Rails.configuration.emails.reminders_mailbox!,
      message_stream: :broadcast
    )
  end

  def welcome
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @developer = @notification.developer

    mail(
      to: recipient.email,
      subject: @notification.title
    )
  end

  def first_message
    @developer = params[:developer]

    mail(
      to: @developer.user.email,
      subject: t(".subject")
    )
  end
end
