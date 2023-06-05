require "test_helper"

class UpdateDeveloperResponseRateJobTest < ActiveJob::TestCase
  include BusinessesHelper

  setup do
    @developer = developers(:one)
    create_answered_message_for(@developer)
    create_ignored_message_for(@developer, grace_period_expired: true)
    UpdateDeveloperResponseRateJob.perform_now(@developer.id)
  end

  test "should update developer response" do
    UpdateDeveloperResponseRateJob.perform_now(@developer.id)

    assert_equal 50, @developer.reload.response_rate
  end

  test "should not take into account unreplied conversations created during grace period" do
    assert_no_changes @developer.reload.response_rate do
      create_ignored_message_for(@developer, grace_period_expired: false)

      UpdateDeveloperResponseRateJob.perform_now(@developer.id)
    end
  end

  test "should increase response rate if replied to within grace period" do
    assert_changes -> { @developer.reload.response_rate }, from: 50, to: 67 do
      create_answered_message_for(@developer, grace_period_expired: false)

      UpdateDeveloperResponseRateJob.perform_now(@developer.id)
    end
  end

  test "should reduce response rate if not replied to beyond grace period" do
    assert_changes -> { @developer.reload.response_rate }, from: 50, to: 33 do
      create_ignored_message_for(@developer, grace_period_expired: true)

      UpdateDeveloperResponseRateJob.perform_now(@developer.id)
    end
  end

  private

  def create_answered_message_for(developer, grace_period_expired: false)
    conversation = start_conversation(developer, grace_period_expired)
    Message.create!(conversation:, sender: developer, body: "First reply")
  end

  def create_ignored_message_for(developer, grace_period_expired: false)
    start_conversation(developer, grace_period_expired)
  end

  def start_conversation(developer, grace_period_expired)
    business = Business.create!(business_attributes)
    conversation = Conversation.create!(developer:, business:)

    if grace_period_expired
      grace_period = Rails.application.config.developer_response_grace_period || 0.seconds
      conversation.update!(created_at: grace_period.ago - 1.hour)
    end

    Message.create!(conversation:, sender: business, body: "First contact")
    conversation
  end
end
