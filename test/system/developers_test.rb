require "application_system_test_case"

class DevelopersSpec < ApplicationSystemTestCase
  test "developers availability sort click adds sort param", js: true do
    visit developers_path
  end
end