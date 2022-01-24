require "test_helper"

class FinancialTest < ActiveSupport::TestCase
  setup do
    report = IncomeReport.new
    @expenses = report.expenses
    @revenue = report.revenue
  end

  test "expenses has headers" do
    assert_equal(@expenses["headers"].blank?, false, "Headers missing for expenses")
  end

  test "expenses has data" do
    assert_equal(@expenses["data"].blank?, false, "Data missing for expenses")
  end

  test "headers match data columns for expenses" do
    assert_equal(@expenses["headers"].size, @expenses["data"].first.size, "Headers and data mismatch")
  end

  test "expenses entry have valid dates" do
    @expenses["data"].each do |entry|
      entry["date"].to_date
    rescue
      assert(false, "Date for entry '#{entry["description"]}' is not valid")
    end
    assert(true)
  end

  test "expenses entry total is a number" do
    @expenses["data"].each do |entry|
      assert(false, "Total for entry '#{entry["description"]}' is not valid") unless entry["total"].is_a?(Numeric)
    end
    assert(true)
  end

  test "revenue has headers" do
    assert_equal(@revenue["headers"].blank?, false, "Headers missing for revenue")
  end

  test "revenue has data" do
    assert_equal(@revenue["data"].blank?, false, "Data missing for revenue")
  end

  test "headers match data columns for revenue" do
    assert_equal(@revenue["headers"].size, @revenue["data"].first.size, "Headers and data mismatch")
  end

  test "revenue entry have valid dates" do
    @revenue["data"].each do |entry|
      entry["date"].to_date
    rescue
      assert(false, "Date for entry '#{entry["description"]}' is not valid")
    end
    assert(true)
  end

  test "revenue entry total is a number" do
    @revenue["data"].each do |entry|
      assert(false, "Total for entry '#{entry["description"]}' is not valid") unless entry["total"].is_a?(Numeric)
    end
    assert(true)
  end
end
