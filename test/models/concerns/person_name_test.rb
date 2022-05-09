require "test_helper"

class PersonNameTest < ActiveSupport::TestCase
  test "first name is everything before the first space, removing whitespace" do
    developer = Developer.new(name: " Joseph  Anthony     Masilotti")
    assert_equal "Joseph", developer.first_name
  end

  test "first name edge cases" do
    assert_equal "42", Developer.new(name: 42).first_name
    assert_nil Developer.new(name: nil).first_name
  end

  test "businesses, too" do
    assert_equal "Duke", Business.new(name: "Duke Masilotti").first_name
  end
end
