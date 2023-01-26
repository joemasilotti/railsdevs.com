require "test_helper"

class Developers::PaywalledSearchResultsTest < ActiveSupport::TestCase
  include FeatureHelper

  test "unauthorized page when user is not a subscriber and not on page 1" do
    stub_feature_flag(:paywalled_search_results, true) do
      refute paywall(user: users(:subscribed_business), page: 1).unauthorized_page?
      refute paywall(user: users(:subscribed_business), page: 2).unauthorized_page?
      refute paywall(user: users(:empty), page: 1).unauthorized_page?
      assert paywall(user: users(:empty), page: 2).unauthorized_page?
    end

    stub_feature_flag(:paywalled_search_results, false) do
      refute paywall(user: users(:empty), page: 2).unauthorized_page?
    end
  end

  test "show the paywall when the user is not a subscriber or not enough results to trigger pagination" do
    stub_feature_flag(:paywalled_search_results, true) do
      assert paywall(user: users(:empty)).show_paywall?(11)
      refute paywall(user: users(:empty)).show_paywall?(9)
      refute paywall(user: users(:subscribed_business)).show_paywall?(11)
    end

    stub_feature_flag(:paywalled_search_results, false) do
      refute paywall(user: users(:empty)).show_paywall?(11)
    end
  end

  def paywall(user:, page: 5)
    Developers::PaywalledSearchResults.new(user:, page:)
  end
end
