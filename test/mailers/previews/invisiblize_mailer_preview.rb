class InvisiblizeMailerPreview < ActionMailer::Preview
  def to_developer
    notification = Notification.where(type: Developers::InvisiblizeNotification.to_s).first
    InvisiblizeMailer.with(record: notification, recipient: notification.recipient).to_developer
  end

  def to_business
    notification = Notification.where(type: Businesses::InvisiblizeNotification.to_s).first
    InvisiblizeMailer.with(record: notification, recipient: notification.recipient).to_business
  end
end
