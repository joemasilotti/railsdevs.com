class OfferMailer < ApplicationMailer
  default from: Rails.configuration.emails.notifications_mailbox!

  def new_offer
    @notification = params[:record].to_notification
    @recipient = params[:recipient]

    @offer = @notification.offer
    @sender = @offer.sender.name

    conversation_token = @offer.conversation.inbound_email_token

    mail(
      to: @recipient.email,
      subject: @notification.email_subject,
      reply_to: "#{@sender} <conversation+#{conversation_token}@inbound.railsdevs.com>"
    )
  end
end
