class DeveloperMailer < ApplicationMailer
  def welcome
    @developer = params[:developer]
    mail(to: @developer.user.email, subject: t(".subject"))
  end

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

  def celebration_promotion
    @conversation = params[:conversation]
    @developer = @conversation.developer
    @business = @conversation.business

    mail(
      to: @developer.user.email,
      from: Rails.configuration.emails.reminders_mailbox!,
      subject: t(".subject", contact: @business.contact_name, company: @business.company),
      message_stream: :broadcast
    )
  end

  def first_message
    @developer = params[:developer]

    mail(
      to: @developer.user.email,
      subject: t(".subject")
    )
  end

  def product_announcement
    @notification = params[:record].to_notification
    recipient = params[:recipient]
    @developer = @notification.developer

    mail(
      to: recipient.email,
      subject: @notification.email_subject,
      from: Rails.configuration.emails.updates_mailbox!,
      message_stream: :broadcast
    )
  end

  def shut_down
    @developer = params[:developer]

    mail(
      to: @developer.user.email,
      subject: "Thank you for being part of RailsDevs ❤️",
      reply_to: "joe@masilotti.com"
    )
  rescue Postmark::InactiveRecipientError => e
    Rails.logger.warn("Postmark inactive recipient: #{e.message}")
  end
end
