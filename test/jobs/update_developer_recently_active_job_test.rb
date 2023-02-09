require "test_helper"

class UpdateDeveloperRecentlyActiveJobTest < ActiveJob::TestCase
  setup do
    @developer = developers(:one)
  end

  test "update recently active to true" do
    @developer.badge.update!(recently_active: false)

    assert_changes "@developer.reload.recently_active?" do
      UpdateDeveloperRecentlyActiveJob.perform_now(@developer.id, true)
    end
  end

  test "update recently active to false" do
    @developer.badge.update!(recently_active: true)

    assert_changes "@developer.reload.recently_active?" do
      UpdateDeveloperRecentlyActiveJob.perform_now(@developer.id, false)
    end
  end
end
