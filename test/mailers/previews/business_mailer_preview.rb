class BusinessMailerPreview < ActionMailer::Preview
  def welcome
    business = Business.first
    BusinessMailer.with(business: business).welcome
  end

  def subscribed
    business = Business.first
    BusinessMailer.with(business:).subscribed
  end

  def cancel_subscription
    business = Business.first
    BusinessMailer.with(business:).cancel_subscription
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

  def survey
    business = Business.first
    BusinessMailer.with(business:).survey
  end

  def shut_down
    business = Business.first
    BusinessMailer.with(business:).shut_down
  end
end
