class BusinessMailerPreview < ActionMailer::Preview
  def developer_profiles
    business = Business.first
    developers = Developer.limit(3)

    BusinessMailer.with(business:, developers:).developer_profiles
  end

  def welcome_business
    BusinessMailer.with(business: Business.first).welcome_email
  end
end
