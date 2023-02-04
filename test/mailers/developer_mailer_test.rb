require "test_helper"

class DeveloperMailerTest < ActionMailer::TestCase
  test "stale" do
    assert_emails 1 do
      Developers::ProfileReminderNotification.with(developer:).deliver(recipient)
    end
  end

  test "welcome" do
    assert_emails 1 do
      Developers::WelcomeNotification.with(developer:).deliver(recipient)
    end
  end

  test "first message" do
    # TODO: Make an assertion here
    DeveloperMailer.with(developer:).first_message
  end

  def developer
    developers(:one)
  end

  def recipient
    developer.user
  end
end
