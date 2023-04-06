class PayMailer < Pay::UserMailer
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
