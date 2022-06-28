require "test_helper"

class SignificantFigureTest < ActiveSupport::TestCase
  test "rounds numbers less than 100 down to 2 significant figures" do
    assert_equal 10, SignificantFigure.new(12).rounded
    assert_equal 10, SignificantFigure.new(19).rounded
  end

  test "rounds numbers greater than or equal to 100 down to 1 significant figure" do
    assert_equal 100, SignificantFigure.new(120).rounded
    assert_equal 100, SignificantFigure.new(190).rounded
  end
end
