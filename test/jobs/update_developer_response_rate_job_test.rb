require "test_helper"

class UpdateDeveloperResponseRateJobTest < ActiveJob::TestCase
  include BusinessesHelper
  setup do
    @developer = developers(:one)

    # Create a conversation that has been replied to.
    business = Business.create!(business_attributes)
    conversation = Conversation.create!(
      developer: @developer,
      business: business,
      created_at: UpdateDeveloperResponseRateJob::GRACE_PERIOD.ago - 1.day
    )
    Message.create!(conversation: conversation, sender: business, body: "First contact")
    Message.create!(conversation: conversation, sender: @developer, body: "First reply")

    # Create a conversation that has not been replied to.
    business = Business.create!(business_attributes)
    conversation = Conversation.create!(
      developer: @developer,
      business: business,
      created_at: UpdateDeveloperResponseRateJob::GRACE_PERIOD.ago - 1.day
    )
    Message.create!(conversation: conversation, sender: business, body: "Second contact")

    # update the developer's response rate
    UpdateDeveloperResponseRateJob.perform_now(@developer.reload)
  end

  test "should update developer response rate from the returned value" do
    replied_rate = 0.42
    expected_response_rate = 42
    mock = Minitest::Mock.new
    mock.expect :replied_rate, replied_rate

    Stats::Conversation.stub :new, mock do
      UpdateDeveloperResponseRateJob.perform_now(@developer.reload)
      assert_equal expected_response_rate, @developer.reload.response_rate
    end
    assert_mock mock
  end

  test "should not take into account unreplied conversations created during grace period" do
    before = @developer.reload.response_rate

    business = Business.create!(business_attributes)
    conversation = Conversation.create!(developer: @developer, business: business)
    Message.create!(conversation: conversation, sender: business, body: "First contact")
    UpdateDeveloperResponseRateJob.perform_now(@developer.reload)

    assert_equal @developer.reload.response_rate, before
  end

  test "should increase response rate if replied to within grace period" do
    before = @developer.reload.response_rate

    business = Business.create!(business_attributes)
    conversation = Conversation.create!(developer: @developer, business: business)
    Message.create!(conversation: conversation, sender: business, body: "First contact")
    Message.create!(conversation: conversation, sender: @developer, body: "First reply")
    UpdateDeveloperResponseRateJob.perform_now(@developer.reload)

    assert_operator @developer.reload.response_rate, :>, before
  end

  test "should reduce response rate if not replied to beyond grace period" do
    before = @developer.response_rate

    business = Business.create!(business_attributes)
    conversation = Conversation.create!(
      developer: @developer,
      business: business,
      created_at: UpdateDeveloperResponseRateJob::GRACE_PERIOD.ago - 1.hour
    )
    Message.create!(conversation: conversation, sender: business, body: "First contact")

    UpdateDeveloperResponseRateJob.perform_now(@developer.reload)
    assert_operator @developer.reload.response_rate, :<, before
  end
end
