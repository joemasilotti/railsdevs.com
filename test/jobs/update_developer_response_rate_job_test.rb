require "test_helper"

class UpdateDeveloperResponseRateJobTest < ActiveJob::TestCase
  include BusinessesHelper
  setup do
    @developer = developers(:one)
    business = businesses(:one)
    conversation = Conversation.new(
      developer: @developer,
      business: business,
      created_at: UpdateDeveloperResponseRateJob::GRACE_PERIOD.ago - 1.day
    )
    Message.create!(conversation: conversation, sender: business, body: "First contact")
    Message.create!(conversation: conversation, sender: @developer, body: "First reply")
    UpdateDeveloperResponseRateJob.perform_now(@developer)
  end

  test "should update developer response rate" do
    replied_rate = 0.42
    expected_response_rate = 42
    mock = Minitest::Mock.new
    mock.expect :replied_rate, replied_rate

    Stats::Conversation.stub :new, mock do
      UpdateDeveloperResponseRateJob.perform_now(@developer)
      assert_equal expected_response_rate, @developer.reload.response_rate
    end
    assert_mock mock
  end

  test "should not include conversations created during grace period" do
    before = @developer.response_rate

    Conversation.create!(
      developer: @developer,
      business: Business.create!(business_attributes)
    )
    UpdateDeveloperResponseRateJob.perform_now(@developer)

    assert_equal @developer.reload.response_rate, before
  end

  test "should reduce response rate if not replied to beyond grace period" do
    before = @developer.response_rate

    Conversation.create!(
      developer: @developer,
      business: Business.create!(business_attributes)
    )

    travel UpdateDeveloperResponseRateJob::GRACE_PERIOD + 1.minute do
      UpdateDeveloperResponseRateJob.perform_now(@developer)
      assert_operator @developer.reload.response_rate, :<, before
    end
  end
end
