require "test_helper"

class DeveloperMailerTest < ActionMailer::TestCase
  test "invisiblize" do
    Developers::InvisiblizeNotification.with(developer:).deliver(recipient)
  end

  test "stale" do
    Developers::ProfileReminderNotification.with(developer:).deliver(recipient)
  end

  test "welcome" do
    Developers::WelcomeNotification.with(developer:).deliver(recipient)
  end

  def developer
    developers(:one)
  end

  def recipient
    developer.user
  end
end
