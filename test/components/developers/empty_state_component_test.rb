require "test_helper"

module Developers
  class EmptyStateComponentTest < ViewComponent::TestCase
    test "Renders the default empty state message" do
      render_inline(EmptyStateComponent.new)

      assert_selector("h3", text: "No developers found")
      assert_selector("p", text: "Try changing or clearing your filters.")
      assert_selector "svg"
    end

    test "Renders title, unseeded_body and icon" do
      render_inline(EmptyStateComponent.new(show_unseeded_message: true))

      assert_selector("p", text: "Run bin/rails db:seed to create development data.")
    end
  end
end
