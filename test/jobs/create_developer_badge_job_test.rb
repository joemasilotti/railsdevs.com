require "test_helper"

class CreateDeveloperBadgeJobTest < ActiveJob::TestCase
  setup do
    @developer = developers(:one)
  end

  test "should create developer badges" do
    @developer.badge.destroy

    assert_difference "Developers::Badge.count", 1 do
      CreateDeveloperBadgeJob.perform_now(@developer.id)
    end
  end

  test "should not create developer badges if already has one" do
    assert_no_difference "Developers::Badge.count"  do
      CreateDeveloperBadgeJob.perform_now(@developer.id)
    end
  end
end
