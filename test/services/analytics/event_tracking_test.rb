require "test_helper"

class Analytics::EventTrackingTest < ActiveSupport::TestCase
  test "tracks goals in the config" do
    event = Analytics::EventTracking.new(:added_developer_profile, url:).create_event

    assert_equal url, event.url
    assert_equal "TEST_DEV", event.goal
    assert_equal 0, event.value
  end

  test "raises for unknown goals" do
    assert_raises Analytics::EventTracking::UnknownGoal do
      Analytics::EventTracking.new(:unknown_event, url:).create_event
    end
  end

  test "converts value in dollars to value in cents" do
    event = Analytics::EventTracking.new(:subscribed_to_busines_plan, url:, value: 99).create_event

    assert_equal 9900, event.value
  end

  def url
    "https://example.com"
  end
end
