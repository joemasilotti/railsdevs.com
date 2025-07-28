ActionMailer::MailDeliveryJob.class_eval do
  def perform(mailer, mail_method, delivery_method, args)
    super
  rescue Postmark::InactiveRecipientError => e
    Rails.logger.warn("Postmark inactive recipient: #{e.message}")
  end
end
