ActionMailer::MailDeliveryJob.class_eval do
  def perform_now
    super
  rescue Postmark::InactiveRecipientError => e
    Rails.logger.warn("Postmark inactive recipient: #{e.message}")
  end
end
