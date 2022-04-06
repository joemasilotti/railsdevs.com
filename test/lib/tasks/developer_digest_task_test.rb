require "test_helper"

class DeveloperDigestTaskTest < ActionMailer::TestCase
  include DevelopersHelper
  include RakeTaskHelper

  test "sends appropriate emails for developer digests" do
    load_rake_tasks_once

    travel_to monday do
      Developer.create!(developer_attributes.merge(created_at: 1.day.ago))

      businesses(:subscriber).update!(developer_notifications: :daily)
      assert_emails 1 do
        Rake::Task["developer_digest:daily"].invoke
      end

      businesses(:subscriber).update!(developer_notifications: :weekly)
      assert_emails 1 do
        Rake::Task["developer_digest:weekly"].invoke
      end
    end
  end

  def monday
    Time.zone.local(2022, 1, 3).noon
  end
end
