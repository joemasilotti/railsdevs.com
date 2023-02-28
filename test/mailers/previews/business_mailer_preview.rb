class BusinessMailerPreview < ActionMailer::Preview
  def welcome
    business = Business.first
    BusinessMailer.with(business: business).welcome
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
