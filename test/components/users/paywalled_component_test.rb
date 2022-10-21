require "test_helper"

module Users
  class PaywalledComponentTest < ViewComponent::TestCase
    setup do
      @user = users(:business)
      @resource = developers(:one)
      @content = "Paywalled content"
    end

    test "restricts paywalled content" do
      render_inline(PaywalledComponent.new(@user, @resource)) { @content }
      assert_no_text @content
    end

    test "shows paywalled content when authorized" do
      user = users(:subscribed_business)
      render_inline(PaywalledComponent.new(user, @resource)) { @content }
      assert_text @content
    end

    test "shows paywalled content with a valid public profile keys" do
      public_key = @resource.public_profile_key
      render_inline(PaywalledComponent.new(nil, @resource, public_key:)) { @content }
      assert_text @content
    end

    test "shows a small CTA" do
      render_inline(PaywalledComponent.new(@user, @resource, size: :small)) { @content }

      assert_text I18n.t("users.paywalled_component.title")
      assert_no_text I18n.t("users.paywalled_component.description")
    end

    test "shows a large CTA" do
      render_inline(PaywalledComponent.new(@user, @resource, size: :large)) { @content }

      assert_text I18n.t("users.paywalled_component.title")
      assert_text I18n.t("users.paywalled_component.description")
    end
  end
end
