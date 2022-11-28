require "test_helper"

class Developers::PaywalledSearchResultsTest < ActiveSupport::TestCase
  test "unauthorized page when user is not a subscriber and not on page 1" do
    # :paywalled_search_results
    Feature.stub(:enabled?, true) do
      refute paywall(user: users(:subscribed_business), page: 1).unauthorized_page?
      refute paywall(user: users(:subscribed_business), page: 2).unauthorized_page?
      refute paywall(user: users(:empty), page: 1).unauthorized_page?
      assert paywall(user: users(:empty), page: 2).unauthorized_page?
    end

    # :paywalled_search_results
    Feature.stub(:enabled?, false) do
      refute paywall(user: users(:empty), page: 2).unauthorized_page?
    end
  end

  test "show the paywall when the user is not a subscriber" do
    # :paywalled_search_results
    Feature.stub(:enabled?, true) do
      assert paywall(user: users(:empty)).show_paywall?
      refute paywall(user: users(:subscribed_business)).show_paywall?
    end

    # :paywalled_search_results
    Feature.stub(:enabled?, false) do
      refute paywall(user: users(:empty)).show_paywall?
    end
  end

  def paywall(user:, page: 5)
    Developers::PaywalledSearchResults.new(user:, page:)
  end
end
