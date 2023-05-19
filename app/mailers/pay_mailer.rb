class PayMailer < Pay::UserMailer
  # Use our custom templates if they exist, otherwise fall back to Pay
  default template_path: %w[pay_mailer pay/user_mailer]

  def subscription_renewing
    @business = params[:pay_customer].owner.business
    @renewal_date = params[:date].to_date

    mail(
      to: @business.user.email,
      from: Rails.configuration.emails.support_mailbox!,
      reply_to: Rails.configuration.emails.support!,
      message_stream: "outbound",
      subject: t(".subject")
    )
  end
end
