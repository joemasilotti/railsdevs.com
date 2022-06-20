require "test_helper"

class Analytics::EventsTest < ActionDispatch::IntegrationTest
  setup do
    @event = analytics_events(:one)
  end

  test "viewing an event sets the flash" do
    get analytics_event_path(@event)
    assert_equal flash[:event], {goal: @event.goal, value: @event.value}
  end

  test "viewing an event redirects to the URL" do
    get analytics_event_path(@event)
    assert_redirected_to @event.url
  end

  test "viewing an event marks it as viewed" do
    get analytics_event_path(@event)
    assert @event.reload.tracked?
  end

  test "viewing an already viewed event does not render the flash" do
    @event.track!
    get analytics_event_path(@event)
    assert_nil flash[:event]
  end
end
