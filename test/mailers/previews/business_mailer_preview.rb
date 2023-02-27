class BusinessMailerPreview < ActionMailer::Preview
  def welcome
    notification = Notification.where(type: Businesses::WelcomeNotification.to_s).first
    BusinessMailer.with(record: notification, recipient: notification.recipient).welcome
  end

  def developer_profiles
    business = Business.first
    developers = Developer.limit(3)

    BusinessMailer.with(business:, developers:).developer_profiles
  end

  def new_terms
    business = Business.first
    BusinessMailer.with(business:).new_terms
  end
end
