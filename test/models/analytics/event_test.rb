require "test_helper"

class AnalytisEventTest < ActiveSupport::TestCase
  test "is read if read_at is set" do
    travel_to now do
      event = analytics_events(:one)
      refute event.read?
      assert_nil event.read_at

      event.mark_as_read!
      assert event.read?
      assert_equal event.read_at, now
    end
  end

  def now
    Time.zone.local(2021, 6, 26, 1, 15)
  end
end
