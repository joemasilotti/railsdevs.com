require "test_helper"

module Developers
  class SearchScoreTest < ActiveSupport::TestCase
    setup do
      # 0 baseline score
      @developer = developers(:one)
      @developer.bio = "X" * 51
      @developer.scheduling_link = nil
      @developer.profile_updated_at = 4.months.ago
      @developer.created_at = 2.weeks.ago
    end

    test "large boost for high response rate" do
      @developer.response_rate = HasBadges::HIGH_RESPONSE_RATE_CUTTOFF
      @developer.conversations_count = 1
      @developer.update_search_score
      assert_equal 20, @developer.search_score
    end

    test "large demotion for low response rate" do
      @developer.response_rate = HasBadges::LOW_RESPONSE_RATE_CUTTOFF
      @developer.conversations_count = 1
      @developer.update_search_score
      assert_equal(-20, @developer.search_score)
    end

    test "no change when no conversations" do
      @developer.response_rate = HasBadges::LOW_RESPONSE_RATE_CUTTOFF
      @developer.conversations_count = 0
      @developer.update_search_score
      assert_equal 0, @developer.search_score
    end

    test "large boost for a source contributor" do
      @developer.source_contributor = true
      @developer.update_search_score
      assert_equal 20, @developer.search_score
    end

    test "medium boost for a scheduling link" do
      @developer.scheduling_link = "savvycal.com"
      @developer.update_search_score
      assert_equal 10, @developer.search_score
    end

    test "large boost for profile updated in last month" do
      @developer.profile_updated_at = 3.weeks.ago
      @developer.update_search_score
      assert_equal 20, @developer.search_score
    end

    test "medium boost for profile updated 1-3 months ago" do
      @developer.profile_updated_at = 2.months.ago
      @developer.update_search_score
      assert_equal 10, @developer.search_score
    end

    test "no boost for profile updated 3-6 months ago" do
      @developer.profile_updated_at = 5.months.ago
      @developer.update_search_score
      assert_equal 0, @developer.search_score
    end

    test "medium demotion for profile updated more than 6 months ago" do
      @developer.profile_updated_at = 7.months.ago
      @developer.update_search_score
      assert_equal(-10, @developer.search_score)
    end

    test "extra large boost for profiles added in the last week" do
      @developer.created_at = 6.days.ago
      @developer.update_search_score
      assert_equal 30, @developer.search_score
    end

    test "medium boost for bios with more than 500 characters" do
      @developer.bio = "X" * 501
      @developer.update_search_score
      assert_equal 10, @developer.search_score
    end

    test "large demotion for bios with fewer than 00 characters" do
      @developer.bio = "X" * 49
      @developer.update_search_score
      assert_equal(-20, @developer.search_score)
    end
  end
end
