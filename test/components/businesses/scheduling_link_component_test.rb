require "test_helper"

module Businesses
  class SchedulingLinkComponentTest < ViewComponent::TestCase
    setup do
      @conversation = conversations(:one)
      @business_user = @conversation.business.user
      @developer_user = @conversation.developer.user
    end

    test "renders for business user if developer has scheduling link" do
      update_scheduling_link("https://savvycal.com/prospect")

      render_inline SchedulingLinkComponent.new(@business_user, @conversation)
      assert_text "Schedule a meeting"
    end

    test "doesn't render for business if developer has no scheduling link" do
      update_scheduling_link(nil)

      render_inline SchedulingLinkComponent.new(@business_user, @conversation)
      assert_no_text "Schedule a meeting"
    end

    test "doesn't render for developer" do
      update_scheduling_link("https://savvycal.com/prospect")

      render_inline SchedulingLinkComponent.new(@developer_user, @conversation)
      assert_no_text "Schedule a meeting"
    end

    test "doesn't blow up if no developer" do
      update_scheduling_link(nil)

      render_inline SchedulingLinkComponent.new(@business_user, @conversation)
      assert_no_text "Schedule a meeting"
    end

    private

    def update_scheduling_link(link)
      @conversation.developer.update!(scheduling_link: link)
    end
  end
end
