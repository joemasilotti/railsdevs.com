require "test_helper"

class PaywalledDeveloperTest < ActiveSupport::TestCase
  setup do
    @paywalled_developer = Developers::PaywalledDeveloper.generate
    @paywalled_developers = Developers::PaywalledDeveloper.generate(10)
  end

  test "generator creates one developer if no params given" do
    assert_not @paywalled_developer.respond_to?(:size)
  end

  test "generator creates array for number greater than one" do
    assert @paywalled_developers.respond_to?(:size)
  end
end
