require "test_helper"

class PaywalledDeveloperTest < ActiveSupport::TestCase
  setup do
    @paywalled_developer = Developers::PaywalledDeveloper.generate
  end

  test "encapuslation" do
    assert_raises do
      @paywalled_developer.hero = "This should be encapsulated"
    end
    assert_raises do
      @paywalled_developer.bio = "This should be encapsulated"
    end
    assert_raises do
      @paywalled_developer.avatar_url = "This should be encapsulated"
    end
  end

  test "avatar url generates splash image url" do
    assert_match(/images\.unsplash\.com/, @paywalled_developer.avatar_url)
  end
end
