class OfferMailer < ApplicationMailer
  default from: Rails.configuration.emails.notifications_mailbox!

  def new_offer_notification
    offer_notification("new_offer")
  end

  def offer_accepted_notification
    offer_notification("offer_accepted")
  end

  def offer_declined_notification
    offer_notification("offer_declined")
  end

  private

  def offer_notification(template_name)
    @notification = params[:record].to_notification
    @recipient = params[:recipient]

    @offer = @notification.offer
    @sender = @offer.sender.name

    conversation_token = @offer.conversation.inbound_email_token

    mail(
      to: @recipient.email,
      subject: @notification.email_subject,
      reply_to: "#{@sender} <conversation+#{conversation_token}@inbound.railsdevs.com>",
      template_name: template_name
    )
  end
end
