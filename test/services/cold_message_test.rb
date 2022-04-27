require "test_helper"

class ColdMessageTest < ActiveSupport::TestCase
  include UrlHelpersWithDefaultUrlOptions

  test "builds a new message and conversation" do
    user = users(:subscribed_business)
    developer_id = developers(:one).id

    result = ColdMessage.new({}, developer_id:, user:).build_message

    assert result.success?
    assert result.message.new_record?
    assert result.message.conversation.new_record?
  end

  test "must have a business profile" do
    user = users(:empty)
    developer_id = developers(:one).id

    result = ColdMessage.new({}, developer_id:, user:).build_message

    assert result.redirect?
    assert_equal new_business_path, result.path
  end

  test "must be a new conversation" do
    user = users(:subscribed_business)
    developer_id = developers(:prospect).id

    result = ColdMessage.new({}, developer_id:, user:).build_message

    assert result.redirect?
    assert_equal conversation_path(conversations(:one)), result.path
  end

  test "must have an active business subscription" do
    user = users(:business)
    developer_id = developers(:one).id

    result = ColdMessage.new({}, developer_id:, user:).build_message

    assert result.redirect?
    assert_equal pricing_path, result.path
  end

  test "creates a new message and conversation when sending a message" do
    user = users(:subscribed_business)
    developer_id = developers(:one).id

    result = ColdMessage.new({body: "Hi!"}, developer_id:, user:).send_message

    assert result.success?
    assert result.message.persisted?
    assert_equal "Hi!", result.message.body
  end

  test "applies same redirect logic when sending a message" do
    user = users(:empty)
    developer_id = developers(:one).id

    result = ColdMessage.new({}, developer_id:, user:).send_message

    assert result.redirect?
    assert_equal new_business_path, result.path
  end

  test "must follow the subscription policy when sending a message" do
    user = users(:subscribed_business)
    developer_id = developers(:one).id

    pay_subscriptions(:full_time).update!(processor_plan: BusinessSubscription::PartTime.new.plan)
    developers(:one).role_type.update!(
      part_time_contract: false,
      full_time_contract: false,
      full_time_employment: true
    )

    result = ColdMessage.new({}, developer_id:, user:).send_message

    assert result.redirect?
    assert_equal pricing_path, result.path
  end

  test "fails if the message can't be created when sending a message" do
    user = users(:subscribed_business)
    developer_id = developers(:one).id

    result = ColdMessage.new({body: nil}, developer_id:, user:).send_message

    refute result.success?
    refute result.message.persisted?
  end
end
