require "test_helper"

class HasSocialProfilesTest < ActiveSupport::TestCase
  class Model
    include ActiveModel

    attr_accessor :github, :twitter, :linkedin, :stack_overflow

    def save
      normalize_github
      normalize_twitter
      normalize_linkedin
      normalize_stack_overflow
    end

    def self.before_save(method, options)
    end

    # Must be after .before_save is defined.
    include HasSocialProfiles
  end

  def setup
    @model = Model.new
  end

  test "normalizes GitHub handle" do
    expected = "joemasilotti"
    @model.github = "joemasilotti"
    save_and_assert_normalized_handle(:github, expected)

    @model.github = "http://github.com/joemasilotti"
    save_and_assert_normalized_handle(:github, expected)

    @model.github = "https://github.com/joemasilotti"
    save_and_assert_normalized_handle(:github, expected)

    @model.github = "http://www.github.com/joemasilotti"
    save_and_assert_normalized_handle(:github, expected)

    @model.github = "https://www.github.com/joemasilotti"
    save_and_assert_normalized_handle(:github, expected)
  end

  test "normalizes Twitter handle" do
    expected = "joemasilotti"
    @model.twitter = "joemasilotti"
    save_and_assert_normalized_handle(:twitter, expected)

    @model.twitter = "http://twitter.com/joemasilotti"
    save_and_assert_normalized_handle(:twitter, expected)

    @model.twitter = "https://twitter.com/joemasilotti"
    save_and_assert_normalized_handle(:twitter, expected)

    @model.twitter = "http://www.twitter.com/joemasilotti"
    save_and_assert_normalized_handle(:twitter, expected)

    @model.twitter = "https://www.twitter.com/joemasilotti"
    save_and_assert_normalized_handle(:twitter, expected)
  end

  test "normalizes LinkedIn handle" do
    expected = "joemasilotti"
    @model.linkedin = "joemasilotti"
    save_and_assert_normalized_handle(:linkedin, expected)

    @model.linkedin = "http://linkedin.com/in/joemasilotti"
    save_and_assert_normalized_handle(:linkedin, expected)

    @model.linkedin = "https://linkedin.com/in/joemasilotti"
    save_and_assert_normalized_handle(:linkedin, expected)

    @model.linkedin = "http://www.linkedin.com/in/joemasilotti"
    save_and_assert_normalized_handle(:linkedin, expected)

    @model.linkedin = "https://www.linkedin.com/in/joemasilotti"
    save_and_assert_normalized_handle(:linkedin, expected)
  end

  test "normalizes Stack Overflow handle" do
    expected = "123456"
    @model.stack_overflow = "123456"
    save_and_assert_normalized_handle(:stack_overflow, expected)

    @model.stack_overflow = "http://stackoverflow.com/users/123456/joemasilotti"
    save_and_assert_normalized_handle(:stack_overflow, expected)

    @model.stack_overflow = "https://stackoverflow.com/users/123456/joemasilotti"
    save_and_assert_normalized_handle(:stack_overflow, expected)

    @model.stack_overflow = "http://stackoverflow.com/users/123456"
    save_and_assert_normalized_handle(:stack_overflow, expected)

    @model.stack_overflow = "https://stackoverflow.com/users/123456"
    save_and_assert_normalized_handle(:stack_overflow, expected)

    @model.stack_overflow = "http://www.stackoverflow.com/users/123456/joemasilotti"
    save_and_assert_normalized_handle(:stack_overflow, expected)

    @model.stack_overflow = "https://www.stackoverflow.com/users/123456/joemasilotti"
    save_and_assert_normalized_handle(:stack_overflow, expected)

    @model.stack_overflow = "http://www.stackoverflow.com/users/123456"
    save_and_assert_normalized_handle(:stack_overflow, expected)

    @model.stack_overflow = "https://www.stackoverflow.com/users/123456"
    save_and_assert_normalized_handle(:stack_overflow, expected)
  end

  def save_and_assert_normalized_handle(platform, expected)
    @model.save
    assert_equal @model.send(platform), expected
  end
end
