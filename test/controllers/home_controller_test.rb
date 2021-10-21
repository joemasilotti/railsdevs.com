# frozen_string_literal: true

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "#show home page" do
    get root_path
    assert_response :success
    assert_select "h1", text: "Rails Devs"

    get home_path
    assert_response :success
    assert_select "h1", text: "Rails Devs"
  end
end
