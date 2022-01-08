require "test_helper"

class DeveloperQueryTest < ActiveSupport::TestCase
  test "sort is :availability and defaults to :newest" do
    assert_equal DeveloperQuery.new(sort: "availability").sort, :availability

    assert_equal DeveloperQuery.new(sort: "newest").sort, :newest
    assert_equal DeveloperQuery.new(sort: "bogus").sort, :newest
    assert_equal DeveloperQuery.new(sort: "").sort, :newest
    assert_equal DeveloperQuery.new.sort, :newest
  end

  test "sorting by availability excludes records if not set" do
    records = DeveloperQuery.new(sort: :availability).records
    assert_equal records, [
      developers(:available),
      developers(:unavailable)
    ]
  end

  test "sorting by newest" do
    records = DeveloperQuery.new(sort: :newest).records
    assert_equal records, [
      developers(:available),
      developers(:unavailable),
      developers(:with_conversation),
      developers(:with_blocked_conversation)
    ]
  end

  test "filtering by hourly rate" do
    records = DeveloperQuery.new(hourly_rate: 125).records
    assert_equal records, [developers(:available)]
  end

  test "filtering by salary" do
    records = DeveloperQuery.new(salary: 125_000).records
    assert_equal records, [developers(:available)]
  end

  test "hourly rate and salary are nil if not greater than zero" do
    assert_nil DeveloperQuery.new(hourly_rate: -1).hourly_rate
    assert_nil DeveloperQuery.new(salary: -1).salary

    assert_nil DeveloperQuery.new(hourly_rate: 0).hourly_rate
    assert_nil DeveloperQuery.new(salary: 0).salary

    assert_nil DeveloperQuery.new.hourly_rate
    assert_nil DeveloperQuery.new.salary
  end

  test "filtering by time zones" do
    records = DeveloperQuery.new(time_zones: ["-8"]).records
    assert_equal records, [developers(:unavailable)]
  end

  test "pagy is initialized without errors" do
    assert_not_nil DeveloperQuery.new.pagy
  end
end
