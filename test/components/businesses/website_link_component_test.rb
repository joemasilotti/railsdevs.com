require "test_helper"

module Businesses
  class WebsiteLinkComponentTest < ViewComponent::TestCase
    setup do
      @business = Business.new(company: "Demo Company")
    end

    test "renders company name when the business has no website" do
      render_inline WebsiteLinkComponent.new(@business)
      assert_text "Demo Company"
    end

    test "renders company name with link when the business has a website" do
      @business.website = "democompany.com"

      render_inline WebsiteLinkComponent.new(@business)
      assert_text "Demo Company"
      assert_selector "a[href='https://democompany.com']"
    end

    test "renders normalized link when the link starts with 'http'" do
      @business.website = "http://democompany.com"

      render_inline WebsiteLinkComponent.new(@business)
      assert_text "Demo Company"
      assert_selector "a[href='http://democompany.com']"
    end

    test "renders normalized link when the link starts with 'https'" do
      @business.website = "https://democompany.com"

      render_inline WebsiteLinkComponent.new(@business)
      assert_text "Demo Company"
      assert_selector "a[href='https://democompany.com']"
    end
  end
end
