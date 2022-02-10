require "test_helper"

class HasSocialProfilesTest < ActiveSupport::TestCase
  class Model
    include ActiveModel

    attr_accessor :github, :twitter, :linkedin

    def save
      normalize_github
      normalize_twitter
      normalize_linkedin
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
    @model.github = "joemasilotti"
    @model.save
    assert_equal @model.github, "joemasilotti"

    @model.github = "http://github.com/joemasilotti"
    @model.save
    assert_equal @model.github, "joemasilotti"

    @model.github = "https://github.com/joemasilotti"
    @model.save
    assert_equal @model.github, "joemasilotti"

    @model.github = "http://www.github.com/joemasilotti"
    @model.save
    assert_equal @model.github, "joemasilotti"

    @model.github = "https://www.github.com/joemasilotti"
    @model.save
    assert_equal @model.github, "joemasilotti"
  end

  test "normalizes Twitter handle" do
    @model.twitter = "joemasilotti"
    @model.save
    assert_equal @model.twitter, "joemasilotti"

    @model.twitter = "http://twitter.com/joemasilotti"
    @model.save
    assert_equal @model.twitter, "joemasilotti"

    @model.twitter = "https://twitter.com/joemasilotti"
    @model.save
    assert_equal @model.twitter, "joemasilotti"

    @model.twitter = "http://www.twitter.com/joemasilotti"
    @model.save
    assert_equal @model.twitter, "joemasilotti"

    @model.twitter = "https://www.twitter.com/joemasilotti"
    @model.save
    assert_equal @model.twitter, "joemasilotti"
  end

  test "normalizes LinkedIn handle" do
    @model.linkedin = "joemasilotti"
    @model.save
    assert_equal @model.linkedin, "joemasilotti"

    @model.linkedin = "http://linkedin.com/in/joemasilotti"
    @model.save
    assert_equal @model.linkedin, "joemasilotti"

    @model.linkedin = "https://linkedin.com/in/joemasilotti"
    @model.save
    assert_equal @model.linkedin, "joemasilotti"

    @model.linkedin = "http://www.linkedin.com/in/joemasilotti"
    @model.save
    assert_equal @model.linkedin, "joemasilotti"

    @model.linkedin = "https://www.linkedin.com/in/joemasilotti"
    @model.save
    assert_equal @model.linkedin, "joemasilotti"
  end
end
