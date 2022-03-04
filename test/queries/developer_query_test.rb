require "test_helper"

class DeveloperQueryTest < ActiveSupport::TestCase
  test "sort is :availability and defaults to :newest" do
    assert_equal DeveloperQuery.new(sort: "availability").sort, :availability

    assert_equal DeveloperQuery.new(sort: "newest").sort, :newest
    assert_equal DeveloperQuery.new(sort: "bogus").sort, :newest
    assert_equal DeveloperQuery.new(sort: "").sort, :newest
    assert_equal DeveloperQuery.new.sort, :newest
  end

  test "default searching excludes developers not interested (or blank) search status" do
    records = DeveloperQuery.new.records
    assert_includes records, developers(:with_actively_looking_search_status)
    assert_includes records, developers(:with_open_search_status)
    refute_includes records, developers(:with_not_interested_search_status)
    refute_includes records, developers(:with_conversation) # Blank search status.
  end

  test "sorting by availability excludes records if not set" do
    records = DeveloperQuery.new(sort: :availability).records
    assert_equal records, [
      developers(:complete),
      developers(:available),
      developers(:unavailable)
    ]
  end

  test "sorting by newest" do
    records = DeveloperQuery.new(sort: :newest).records
    assert_equal records, [
      developers(:complete),
      developers(:available),
      developers(:unavailable),
      developers(:with_part_time_contract),
      developers(:with_full_time_contract),
      developers(:with_full_time_employment),
      developers(:with_actively_looking_search_status),
      developers(:with_open_search_status)
    ]
  end

  test "filtering by time zones" do
    records = DeveloperQuery.new(utc_offsets: [PACIFIC_UTC_OFFSET]).records
    assert_equal records, [developers(:unavailable)]
  end

  test "filtering by part-time contract" do
    records = DeveloperQuery.new(role_types: ["part_time_contract"]).records
    assert_equal 2, records.count
    assert_includes records, developers(:with_part_time_contract)
    assert_includes records, developers(:complete)
  end

  test "filtering by full-time contract" do
    records = DeveloperQuery.new(role_types: ["full_time_contract"]).records
    assert_equal 2, records.count
    assert_includes records, developers(:with_full_time_contract)
    assert_includes records, developers(:complete)
  end

  test "filtering by full-time employment" do
    records = DeveloperQuery.new(role_types: ["full_time_employment"]).records
    assert_equal 2, records.count
    assert_includes records, developers(:with_full_time_employment)
    assert_includes records, developers(:complete)
  end

  test "filtering by including developers who aren't interested" do
    records = DeveloperQuery.new(include_not_interested: true).records
    assert_includes records, developers(:with_actively_looking_search_status)
    assert_includes records, developers(:with_open_search_status)
    assert_includes records, developers(:with_not_interested_search_status)
    assert_includes records, developers(:with_conversation) # Blank search status.
  end

  test "pagy is initialized without errors" do
    assert_not_nil DeveloperQuery.new.pagy
  end

  test "returns hash with filters" do
    utc_offsets = [PACIFIC_UTC_OFFSET, EASTERN_UTC_OFFSET]
    filters = {
      sort: :availability,
      utc_offsets:,
      role_types: [:part_time_contract],
      include_not_interested: true
    }
    assert_equal DeveloperQuery.new(filters.dup).filters, filters
  end
end
