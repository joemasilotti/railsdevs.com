require "test_helper"

class Businesses::ProfileTest < ActiveSupport::TestCase
  include BusinessesHelper
  include NotificationsHelper

  setup do
    @user = users(:empty)
  end

  test "building an existing business" do
    result = Businesses::Profile.new(users(:business)).build_profile
    assert result.existing_business?
    refute result.success?
  end

  test "builds a business" do
    result = Businesses::Profile.new(@user).build_profile
    assert result.success?
    assert_not_nil result.business
  end

  test "creates a valid business" do
    assert_changes "Business.count", 1 do
      result = Businesses::Profile.new(@user)
        .create_profile(success_url, business_attributes)
      assert result.success?
      assert result.business.valid?
    end
  end

  test "sends a notification to the admins" do
    assert_sends_notification NewBusinessNotification, to: users(:admin) do
      Businesses::Profile.new(@user)
        .create_profile(success_url, business_attributes)
    end
  end

  test "creates an analytics event" do
    assert_changes "Analytics::Event.count", 1 do
      Businesses::Profile.new(@user)
        .create_profile(success_url, business_attributes)
      assert_equal success_url, Analytics::Event.last.url
    end
  end

  test "creating an existing business" do
    result = Businesses::Profile.new(users(:business))
      .create_profile(success_url, business_attributes)
    assert result.existing_business?
    refute result.success?
  end

  test "invalid records" do
    assert_no_changes "[Business.count, Analytics::Event.count]" do
      result = Businesses::Profile.new(@user)
        .create_profile(success_url, {})
      refute result.success?
      assert_not_nil result.business
    end
  end

  def success_url
    "https://example.com"
  end
end
