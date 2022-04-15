# Preview all emails at http://localhost:3000/rails/mailers/welcome_mailer
class WelcomeMailerPreview < ActionMailer::Preview
  def welcome_developer
    WelcomeMailer.with(developer: Developer.first).developer_welcome_email
  end

  def welcome_business
    WelcomeMailer.with(business: Business.first).business_welcome_email
  end
end
