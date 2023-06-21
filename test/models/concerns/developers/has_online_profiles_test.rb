require "test_helper"

class Developers::HasOnlineProfilesTest < ActiveSupport::TestCase
  def setup
    @model = Developer.new
  end

  test "normalizes website" do
    values = %w[
      http://www.example.com/joemasilotti
      https://www.example.com/joemasilotti
    ]

    values.each do |value|
      @model.website = value
      assert_equal "www.example.com/joemasilotti", @model.website
    end
  end

  test "normalizes Mastodon" do
    values = %w[
      http://server.name/@joemasilotti
      https://server.name/@joemasilotti
    ]

    values.each do |value|
      @model.mastodon = value
      assert_equal "server.name/@joemasilotti", @model.mastodon
    end
  end

  test "normalizes scheduling_link" do
    values = %w[
      http://savvycal.com/joemasilotti/chat
      https://savvycal.com/joemasilotti/chat
    ]

    values.each do |value|
      @model.scheduling_link = value
      assert_equal "savvycal.com/joemasilotti/chat", @model.scheduling_link
    end
  end

  test "normalizes GitHub handle" do
    values = %w[
      joemasilotti
      http://github.com/joemasilotti
      https://github.com/joemasilotti
      http://www.github.com/joemasilotti
      https://www.github.com/joemasilotti
    ]

    values.each do |value|
      @model.github = value
      assert_equal "joemasilotti", @model.github
    end
  end

  test "normalizes Twitter handle" do
    values = %w[
      joemasilotti
      http://twitter.com/joemasilotti
      https://twitter.com/joemasilotti
      http://www.twitter.com/joemasilotti
      https://www.twitter.com/joemasilotti
    ]

    values.each do |value|
      @model.twitter = value
      assert_equal "joemasilotti", @model.twitter
    end
  end

  test "normalizes LinkedIn handle" do
    values = %w[
      joemasilotti
      joemasilotti/
      /joemasilotti/
      http://linkedin.com/in/joemasilotti
      https://linkedin.com/in/joemasilotti
      http://www.linkedin.com/in/joemasilotti
      https://www.linkedin.com/in/joemasilotti
    ]

    values.each do |value|
      @model.linkedin = value
      assert_equal "joemasilotti", @model.linkedin
    end
  end

  test "normalizes Stack Overflow handle" do
    values = %w[
      123456
      http://stackoverflow.com/users/123456/joemasilotti
      https://stackoverflow.com/users/123456/joemasilotti
      http://stackoverflow.com/users/123456
      https://stackoverflow.com/users/123456
      http://www.stackoverflow.com/users/123456/joemasilotti
      https://www.stackoverflow.com/users/123456/joemasilotti
      http://www.stackoverflow.com/users/123456
      https://www.stackoverflow.com/users/123456
    ]

    values.each do |value|
      @model.stack_overflow = value
      assert_equal "123456", @model.stack_overflow
    end
  end
end
