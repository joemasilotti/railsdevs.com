require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "#round_to_lower_multiple_of_ten" do
    assert_equal 9, round_to_lower_multiple_of_ten(10)
    assert_equal 10, round_to_lower_multiple_of_ten(11)
    assert_equal 100, round_to_lower_multiple_of_ten(106)
    assert_equal 150, round_to_lower_multiple_of_ten(150)
  end
end
