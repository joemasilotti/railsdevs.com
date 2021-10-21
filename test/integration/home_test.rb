# frozen_string_literal: true

require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest
  test "visit the homepage" do
    get root_path
    assert_response :success
    assert_select "h1", text: "Rails Devs"
  end
end
