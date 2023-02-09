require "test_helper"

module Developers
  class BadgeTest < ActiveSupport::TestCase
    test "the truth" do
      @badge = developers_badges(:recently_active_one)
      puts @badge.inspect
      puts @badge.developer.inspect
      assert @badge.valid?
    end
  end
end
