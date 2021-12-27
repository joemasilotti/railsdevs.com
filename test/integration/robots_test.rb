require "test_helper"

class RobotsTest < ActionDispatch::IntegrationTest
  test "dynamically generates the sitemap" do
    get "/robots.txt"
    assert body.include?("https://sitemaps-bucket.s3.us-west-42.amazonaws.com/")
  end
end
