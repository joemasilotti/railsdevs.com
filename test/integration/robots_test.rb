require "test_helper"

class RobotsTest < ActionDispatch::IntegrationTest
  test "dynamically generates the sitemap" do
    get "/robots.txt"
    assert body.include?("http://www.example.com/sitemap.xml.gz")
  end
end
