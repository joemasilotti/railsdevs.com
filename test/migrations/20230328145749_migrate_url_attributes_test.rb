require "test_helper"

require Rails.root.join("db/migrate/20230328145749_migrate_url_attributes.rb")

class MigrateUrlAttributesTest < ActiveSupport::TestCase
  test "works for developers" do
    developer = developers(:one)
    developer.update_columns(
      website: "https://www.example.com",
      mastodon: "https://example.com/@mastodon",
      scheduling_link: "https://example.com/chat",
      github: "https://github.com/github_user",
      twitter: "https://twitter.com/twitter_user",
      linkedin: "https://linkedin.com/in/linkedin_user",
      stack_overflow: "https://stackoverflow.com/users/123/so_user"
    )

    assert_no_changes "developer.reload.updated_at" do
      MigrateUrlAttributes.new.up
    end

    assert_equal "www.example.com", developer.website
    assert_equal "example.com/@mastodon", developer.mastodon
    assert_equal "example.com/chat", developer.scheduling_link
    assert_equal "github_user", developer.github
    assert_equal "twitter_user", developer.twitter
    assert_equal "linkedin_user", developer.linkedin
    assert_equal "123", developer.stack_overflow
  end

  test "works for businesses" do
    business = businesses(:one)
    business.update_columns(
      website: "https://www.example.com"
    )

    assert_no_changes "business.reload.updated_at" do
      MigrateUrlAttributes.new.up
    end

    assert_equal "www.example.com", business.website
  end
end
