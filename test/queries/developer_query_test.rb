require "test_helper"

class DeveloperQueryTest < ActiveSupport::TestCase
  include DevelopersHelper

  test "sort is :availability and defaults to :newest" do
    assert_equal DeveloperQuery.new(sort: "availability").sort, :availability

    assert_equal DeveloperQuery.new(sort: "newest").sort, :newest
    assert_equal DeveloperQuery.new(sort: "bogus").sort, :newest
    assert_equal DeveloperQuery.new(sort: "").sort, :newest
    assert_equal DeveloperQuery.new.sort, :newest
  end

  test "default searching excludes developers not interested (or blank) search status" do
    actively_looking = create_developer(search_status: :actively_looking)
    open = create_developer(search_status: :open)
    not_interested = create_developer(search_status: :not_interested)
    blank = create_developer(search_status: nil)

    records = DeveloperQuery.new.records

    assert_includes records, actively_looking
    assert_includes records, open
    refute_includes records, not_interested
    refute_includes records, blank
  end

  test "including developers who aren't currently interested" do
    not_interested = create_developer(search_status: :not_interested)

    records = DeveloperQuery.new.records
    refute_includes records, not_interested

    records = DeveloperQuery.new(include_not_interested: true).records
    assert_includes records, not_interested
  end

  test "featured developers show if on page 1 and no filters" do
    developer = developers(:one)
    developer.touch(:featured_at)
    developers(:prospect).update!(search_status: :open)

    records = DeveloperQuery.new.featured_records
    assert_includes records, developer

    records = DeveloperQuery.new(page: 2, items_per_page: 1).featured_records
    refute_includes records, developer

    {
      utc_offsets: [1],
      role_types: [:full_time_employment],
      role_levels: [:junior],
      include_not_interested: true,
      search_query: "developer"
    }.each do |key, value|
      records = DeveloperQuery.new(key => value, :items_per_page => 1).featured_records
      refute_includes records, developer
    end
  end

  test "sorting by availability excludes developers who haven't set that field" do
    available = create_developer(available_on: Date.yesterday)
    unavailable = create_developer(available_on: Date.tomorrow)
    blank = create_developer(available_on: nil)

    records = DeveloperQuery.new(sort: :availability).records

    assert_includes records, available
    assert_includes records, unavailable
    refute_includes records, blank

    assert records.find_index(available) < records.find_index(unavailable)
  end

  test "sorting by newest" do
    oldest = create_developer
    newest = create_developer

    records = DeveloperQuery.new(sort: :newest).records

    assert records.find_index(newest) < records.find_index(oldest)
  end

  test "filtering by countries" do
    united_states = create_developer
    singapore = create_developer(location_attributes: {country: "Singapore"})

    records = DeveloperQuery.new(countries: ["Singapore"]).records

    assert_includes records, singapore
    refute_includes records, united_states
  end

  test "filtering by time zones" do
    eastern = create_developer(location_attributes: {utc_offset: EASTERN_UTC_OFFSET})
    pacific = create_developer(location_attributes: {utc_offset: PACIFIC_UTC_OFFSET})

    records = DeveloperQuery.new(utc_offsets: [PACIFIC_UTC_OFFSET]).records

    assert_includes records, pacific
    refute_includes records, eastern
  end

  test "filtering by role types" do
    part_time_contract = create_developer(role_type_attributes: {part_time_contract: true})
    full_time_contract = create_developer(role_type_attributes: {full_time_contract: true})
    full_time_employment = create_developer(role_type_attributes: {full_time_employment: true})
    blank = create_developer

    records = DeveloperQuery.new(role_types: ["part_time_contract", "full_time_contract"]).records

    assert_includes records, part_time_contract
    assert_includes records, full_time_contract
    refute_includes records, full_time_employment
    refute_includes records, blank
  end

  test "filtering by role level" do
    junior = create_developer(role_level_attributes: {junior: true})
    mid = create_developer(role_level_attributes: {mid: true})
    senior = create_developer(role_level_attributes: {senior: true})
    blank = create_developer

    records = DeveloperQuery.new(role_levels: ["junior", "mid"]).records

    assert_includes records, junior
    assert_includes records, mid
    refute_includes records, senior
    refute_includes records, blank
  end

  test "filtering developers by their bio or hero does not includes all if business has an active subscription" do
    subscribed_business = users(:subscribed_business)
    loves_oss = create_developer(hero: "I love OSS!")
    likes_oss = create_developer(bio: "I enjoy OSS")
    does_not_mention_oss = create_developer

    records = DeveloperQuery.new(search_query: "OSS", user: subscribed_business).records

    assert_includes records, loves_oss
    assert_includes records, likes_oss
    refute_includes records, does_not_mention_oss
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
      role_levels: [:junior],
      include_not_interested: true,
      search_query: "rails engineer",
      countries: ["United States"]
    }
    assert_equal DeveloperQuery.new(filters.dup).filters, filters
  end
end
