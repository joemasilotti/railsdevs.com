require "test_helper"

class DeveloperMailerTest < ActionMailer::TestCase
  test "invisiblize" do
    InvisiblizeDeveloperNotification.with(developer:).deliver(recipient)
  end

  test "stale" do
    StaleDeveloperNotification.with(developer:).deliver(recipient)
  end

  test "welcome" do
    WelcomeDeveloperNotification.with(developer:).deliver(recipient)
  end

  def developer
    developers(:one)
  end

  def recipient
    developer.user
  end
end
