require "test_helper"

class PaywalledDeveloperTest < ActiveSupport::TestCase
  setup do
    @paywalled_developer = Developers::PaywalledDeveloper.generate
    @paywalled_developers = Developers::PaywalledDeveloper.generate(10)
  end

  test "generator creates array for number greater than one" do
    assert_not @paywalled_developer.respond_to?(:size)
    assert @paywalled_developers.respond_to?(:size)
  end

  test "avatar url generates splash image url" do
    assert_match(/images\.unsplash\.com/, @paywalled_developer.avatar_url)
  end
end
