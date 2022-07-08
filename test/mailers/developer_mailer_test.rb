require "test_helper"

class DeveloperMailerTest < ActionMailer::TestCase
  test "stale" do
    Developers::ProfileReminderNotification.with(developer:).deliver(recipient)
  end

  test "welcome" do
    Developers::WelcomeNotification.with(developer:).deliver(recipient)
  end

  test "first message" do
    DeveloperMailer.with(developer:).first_message
  end

  def developer
    developers(:one)
  end

  def recipient
    developer.user
  end
end
