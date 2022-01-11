require "test_helper"
require "rake"

class DeveloperDigestTaskTest < ActionMailer::TestCase
  test "sends appropriate emails for developer digests" do
    # When the conditional is excluded, the tests will fail when ran with the entire suite
    # but not when run in isolation. I think it has to do with double-loading rake tasks.
    Railsdevs::Application.load_tasks if Rake::Task.tasks.empty?

    assert_emails Business.daily_developer_notifications.length do
      Rake::Task["developer_digest:daily"].invoke
    end

    assert_emails Business.weekly_developer_notifications.length do
      Rake::Task["developer_digest:weekly"].invoke
    end
  end
end
