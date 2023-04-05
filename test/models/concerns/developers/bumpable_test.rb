require "test_helper"

module Developers
  class HasOnlineProfilesTest < ActiveSupport::TestCase
    setup do
      @developer = developers(:one)
    end

    test "touches profile_updated_at if significant changes were made" do
      assert_changes "@developer.profile_updated_at" do
        @developer.update!(bio: "New bio.", user_initiated: true)
      end
    end

    test "touches profile_updated_at if significant association changes were made" do
      assert_changes "@developer.profile_updated_at" do
        @developer.update!(role_type_attributes: {part_time_contract: false}, user_initiated: true)
      end

      assert_changes "@developer.profile_updated_at" do
        @developer.update!(role_level_attributes: {junior: false}, user_initiated: true)
      end

      assert_changes "@developer.profile_updated_at" do
        @developer.update!(location_attributes: {country: "Canada"}, user_initiated: true)
      end

      assert_changes "@developer.profile_updated_at" do
        @developer.update!(specialty_ids: [specialties(:one).id], user_initiated: true)
      end
    end

    test "doesn't touch profile_updated_at if no significant changes were made" do
      assert_no_changes "@developer.profile_updated_at" do
        @developer.update!(
          profile_reminder_notifications: false,
          featured_at: Time.current,
          public_profile_key: "foo-bar",
          response_rate: 100,
          user_initiated: true
        )
      end
    end

    test "doesn't touch profile_updated_at if not initiated from a user action" do
      @developer.save!(touch: false)

      assert_no_changes "@developer.profile_updated_at" do
        @developer.update!(bio: "New bio.", user_initiated: false)
      end
    end
  end
end
