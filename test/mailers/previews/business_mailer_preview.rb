class BusinessMailerPreview < ActionMailer::Preview
  def new_developer_profile
    business = Business.first
    developers = Developer.all.limit(3)

    BusinessMailer.with(business:, developers:).new_developer_profile
  end
end
