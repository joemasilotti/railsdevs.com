require "test_helper"

class DeveloperDigestTaskTest < ActionMailer::TestCase
  include RakeTaskHelper

  test "sends appropriate emails for developer digests" do
    load_rake_tasks_once

    assert_emails 1 do
      Rake::Task["developer_digest:daily"].invoke
    end

    assert_emails 1 do
      Rake::Task["developer_digest:weekly"].invoke
    end
  end
end
