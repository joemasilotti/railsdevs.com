require "test_helper"

class TimeComponentTest < ViewComponent::TestCase
  test "renders the timestamp and human readable" do
    time = Time.zone.local(2021, 6, 26, 0, 59)

    travel_to Time.zone.local(2021, 12, 6) do
      render_inline TimeComponent.new(time)
    end

    assert_selector "time[datetime='2021-06-26T00:59:00Z']" do
      assert_text "5 months ago"
    end
  end
end
