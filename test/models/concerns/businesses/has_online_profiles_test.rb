require "test_helper"

class Businesses::HasOnlineProfilesTest < ActiveSupport::TestCase
  def setup
    @model = Business.new
  end

  test "normalizes website" do
    values = %w[
      http://www.example.com
      https://www.example.com
    ]

    values.each do |value|
      @model.website = value
      assert_equal "www.example.com", @model.website
    end
  end
end
