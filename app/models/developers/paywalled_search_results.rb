module Developers
  class PaywalledSearchResults
    private attr_reader :user, :page

    def initialize(user:, page:)
      @user = user
      @page = page
    end

    def unauthorized_page?
      feature_enabled? && !user_authorized? && not_on_first_page?
    end

    def show_paywall?
      feature_enabled? && !user_authorized?
    end

    private

    def feature_enabled?
      Feature.enabled?(:paywalled_search_results)
    end

    def user_authorized?
      Users::Permission.new(user).authorized?
    end

    def not_on_first_page?
      page > 1
    end
  end
end
