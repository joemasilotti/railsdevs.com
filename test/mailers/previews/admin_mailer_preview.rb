class AdminMailerPreview < ActionMailer::Preview
  def new_developer_profile
    AdminMailer.with(developer: Developer.first, recipient: User.first).new_developer_profile
  end

  def new_business
    AdminMailer.with(business: Business.first, recipient: User.first).new_business
  end
end
