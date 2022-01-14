require "test_helper"

class DeveloperDigestTaskTest < ActionMailer::TestCase
  include RakeTaskHelper

  test "sends appropriate emails for developer digests" do
    load_rake_tasks_once

    assert_emails Business.daily_developer_notifications.length do
      Rake::Task["developer_digest:daily"].invoke
    end

    assert_emails Business.weekly_developer_notifications.length do
      Rake::Task["developer_digest:weekly"].invoke
    end
  end
end
