# frozen_string_literal: true

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "#show home page" do
    visit root_path
    assert_response :success
    assert_text "Rails Devs"

    visit home_path
    assert_response :success
    assert_text "Rails Devs"
  end
end
