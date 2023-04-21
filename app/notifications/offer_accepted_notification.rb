class OfferAcceptedNotification < ApplicationNotification
  include IosNotification

  deliver_by :database
  deliver_by :email, mailer: "OfferMailer", method: :offer_notification

  param :offer
  param :conversation

  def title
    t("notifications.offer_accepted_notification.title", developer: offer.receiver.name)
  end

  def email_subject
    t("notifications.offer_accepted_notification.email_subject", developer: offer.receiver.name)
  end

  def ios_subject
    title
  end

  def url
    conversation_url(conversation)
  end

  def offer
    params[:offer]
  end

  def conversation
    params[:conversation]
  end
end
