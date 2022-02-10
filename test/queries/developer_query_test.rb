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
      developers(:with_blocked_conversation),
      developers(:with_part_time_contract),
      developers(:with_full_time_contract),
      developers(:with_full_time_employment)
    ]
  end

  test "filtering by time zones" do
    records = DeveloperQuery.new(time_zones: ["-8"]).records
    assert_equal records, [developers(:unavailable)]
  end

  test "filtering by part-time contract" do
    records = DeveloperQuery.new(role_types: ["part_time_contract"]).records
    assert_equal records, [developers(:with_part_time_contract)]
  end

  test "filtering by full-time contract" do
    records = DeveloperQuery.new(role_types: ["full_time_contract"]).records
    assert_equal records, [developers(:with_full_time_contract)]
  end

  test "filtering by full-time employment" do
    records = DeveloperQuery.new(role_types: ["full_time_employment"]).records
    assert_equal records, [developers(:with_full_time_employment)]
  end

  test "pagy is initialized without errors" do
    assert_not_nil DeveloperQuery.new.pagy
  end

  test "returns hash with filters" do
    filters = {sort: :availability, time_zones: ["-8, -5"], role_types: [:part_time_contract]}
    assert_equal DeveloperQuery.new(filters.dup).filters, filters
  end
end
