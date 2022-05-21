require "test_helper"

class AnalytisEventTest < ActiveSupport::TestCase
  test "is tracked if tracked_at is set" do
    travel_to now do
      event = analytics_events(:one)
      refute event.tracked?
      assert_nil event.tracked_at

      event.track!
      assert event.tracked?
      assert_equal event.tracked_at, now
    end
  end

  def now
    Time.zone.local(2021, 6, 26, 1, 15)
  end
end
