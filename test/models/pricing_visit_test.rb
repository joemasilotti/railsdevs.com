require "test_helper"

class PricingVisitTest < ActiveSupport::TestCase
  test "tracks a visit" do
    session = {}

    visit = PricingVisit.new(session)
    refute visit.visited?

    visit.track_visit
    assert visit.visited?
  end
end
