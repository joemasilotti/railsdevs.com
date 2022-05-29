require "test_helper"

class Developers::NotificationsIntegrationTest < ActionDispatch::IntegrationTest
  include DevelopersHelper

  test "successful edit of notification settings" do
    developer = create_developer
    user = developer.user
    sign_in user

    assert developer.send_stale_notification?

    patch developer_notifications_path(developer), params: {
      developer: {
        send_stale_notification: false
      }
    }

    assert_redirected_to developer_notifications_path(developer)
    refute developer.reload.send_stale_notification?
  end
end
