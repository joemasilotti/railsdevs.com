class AdminMailerPreview < ActionMailer::Preview
  def new_developer_profile
    AdminMailer.with(developer: Developer.first, recipient: User.first).new_developer_profile
  end
end
