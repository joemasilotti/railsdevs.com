require "test_helper"

class RoleTypeTest < ActiveSupport::TestCase
  include DevelopersHelper

  test "after update callback" do
    developer = Developer.create!(developer_attributes.merge(created_at: 30.days.ago))
    role_type = RoleType.create!(full_time_employment: true, developer:)

    assert_difference "Notification.count", 1 do
      role_type.update!(full_time_employment: false)
    end
  end
end