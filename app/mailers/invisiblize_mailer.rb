class InvisiblizeMailer < ApplicationMailer
  def to_developer
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @developer = @notification.developer

    mail(
      to: recipient.email,
      subject: @notification.title
    )
  end

  def to_business
    @notification = params[:record].to_notification
    recipient = params[:recipient]

    @business = @notification.business

    mail(
      to: recipient.email,
      subject: @notification.title
    )
  end
end
