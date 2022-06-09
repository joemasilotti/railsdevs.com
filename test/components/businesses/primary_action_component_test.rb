require "test_helper"

module Businesses
  class PrimaryActionComponentTest < ViewComponent::TestCase
    include UrlHelpersWithDefaultUrlOptions

    test "renders an edit button if the user owns the business" do
      render_inline PrimaryActionComponent.new(businesses(:one), user: users(:business))
      assert_selector "a[href='#{edit_business_path(businesses(:one))}']"

      render_inline PrimaryActionComponent.new(businesses(:one), user: nil)
      assert_no_selector "a"
    end
  end
end
