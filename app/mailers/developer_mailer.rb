class DeveloperMailer < ApplicationMailer
  helper :messages

  def invisiblize
    @notification = params[:record]
    recipient = params[:recipient]

    @developer = @notification.to_notification.developer

    mail(
      to: recipient.email,
      subject: @notification.to_notification.title
    )
  end

  def stale
    @notification = params[:record]
    recipient = params[:recipient]

    @developer = @notification.to_notification.developer

    mail(
      to: recipient.email,
      subject: @notification.to_notification.title,
      from: Rails.configuration.emails.reminders_mailbox!,
      message_stream: :broadcast
    )
  end

  def welcome
    @notification = params[:record]
    recipient = params[:recipient]

    @developer = @notification.to_notification.developer

    mail(
      to: recipient.email,
      subject: @notification.to_notification.title
    )
  end
end
