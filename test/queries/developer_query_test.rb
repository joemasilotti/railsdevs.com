require "test_helper"

class DeveloperQueryTest < ActiveSupport::TestCase
  include DevelopersHelper

  test "sort defaults to :newest" do
    assert_equal DeveloperQuery.new(sort: "newest").sort, :newest

    assert_equal DeveloperQuery.new(sort: "recommended").sort, :recommended
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

  test "filtering by response rate badge" do
    high_response_rate_developer = developers(:prospect)
    low_response_rate_developer = developers(:one)

    UpdateDeveloperResponseRateJob.perform_now(high_response_rate_developer.id)
    UpdateDeveloperResponseRateJob.perform_now(low_response_rate_developer.id)

    records = DeveloperQuery.new(badges: ["high_response_rate"]).records
    assert_includes records, high_response_rate_developer
    refute_includes records, low_response_rate_developer
  end

  test "filtering by source contributor badge" do
    source_contributor = create_developer(source_contributor: true)
    not_source_contributor = create_developer(source_contributor: false)

    records = DeveloperQuery.new(badges: ["source_contributor"]).records
    assert_includes records, source_contributor
    refute_includes records, not_source_contributor
  end

  test "filtering by recently added badge" do
    recently_added_developer = create_developer
    assert recently_added_developer.recently_added?
    not_recently_added_developer = create_developer(created_at: 2.weeks.ago)
    refute not_recently_added_developer.recently_added?

    records = DeveloperQuery.new(badges: ["recently_added"]).records
    assert_includes records, recently_added_developer
    refute_includes records, not_recently_added_developer
  end

  test "filtering by recently updated badge" do
    recently_updated_developer = create_developer(profile_updated_at: 1.day.ago)
    assert recently_updated_developer.recently_updated?
    not_recently_updated_developer = create_developer(profile_updated_at: 2.weeks.ago)
    refute not_recently_updated_developer.recently_updated?

    records = DeveloperQuery.new(badges: ["recently_updated"]).records
    assert_includes records, recently_updated_developer
    refute_includes records, not_recently_updated_developer
  end

  test "filtering by specialties" do
    turbo = Specialty.create!(name: "Turbo")
    stimulus = Specialty.create!(name: "Stimulus")
    react = Specialty.create!(name: "React")

    hotwire_developer = create_developer(specialty_ids: [turbo.id, stimulus.id])
    turbo_developer = create_developer(specialty_ids: [turbo.id])
    stimulus_developer = create_developer(specialty_ids: [stimulus.id])
    react_developer = create_developer(specialty_ids: [react.id])
    developer = create_developer

    records = DeveloperQuery.new(specialty_ids: [turbo.id, stimulus.id]).records
    assert_includes records, hotwire_developer
    assert_includes records, turbo_developer
    assert_includes records, stimulus_developer
    refute_includes records, react_developer
    refute_includes records, developer
    assert_equal records.length, records.uniq.length
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
      sort: :newest,
      utc_offsets:,
      role_types: [:part_time_contract],
      role_levels: [:junior],
      include_not_interested: true,
      search_query: "rails engineer",
      countries: ["United States"],
      badges: [:recently_added]
    }
    assert_equal DeveloperQuery.new(filters.dup).filters, filters
  end
end
