# frozen_string_literal: true

require "test_helper"

class DeveloperTest < ActiveSupport::TestCase
  setup do
    @developer = developers(:one)
  end

  test "unspecified availability" do
    @developer.available_on = nil

    assert_equal :unspecified, @developer.availability_status
    assert @developer.available_now? == false
  end

  test "available in a future date" do
    @developer.available_on = Date.today + 2.weeks

    assert_equal :in_future, @developer.availability_status
    assert @developer.available_now? == false
  end

  test "available from a past date" do
    @developer.available_on = Date.today - 3.weeks

    assert_equal :available, @developer.availability_status
    assert @developer.available_now? == true
  end

  test "available from today" do
    @developer.available_on = Date.today

    assert_equal :available, @developer.availability_status
    assert @developer.available_now? == true
  end
end
