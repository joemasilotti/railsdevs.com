require "test_helper"

module Developers
  class QueryPolicyTest < ActiveSupport::TestCase
    test "search query are permitted for active business subscriptions" do
      user = nil
      policy = Developers::QueryPolicy.new(user, nil)
      refute_includes policy.permitted_attributes, :search_query

      user = users(:business)
      policy = Developers::QueryPolicy.new(user, nil)
      refute_includes policy.permitted_attributes, :search_query

      user = users(:subscribed_business)
      policy = Developers::QueryPolicy.new(user, nil)
      assert_includes policy.permitted_attributes, :search_query
    end
  end
end
