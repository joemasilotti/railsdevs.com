require "test_helper"

module Developers
  class BadgeTest < ActiveSupport::TestCase
    test "the truth" do
      badge = developers_badges(:one)
      assert badge.valid?
    end
  end
end
