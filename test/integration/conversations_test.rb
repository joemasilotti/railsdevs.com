require "test_helper"

class ConversationsTest < ActionDispatch::IntegrationTest
  include NotificationsHelper

  test "you must be signed in" do
    get conversations_path
    assert_redirected_to new_user_registration_path

    get conversation_path(conversations(:one))
    assert_redirected_to new_user_registration_path
  end

  test "you can view your conversations (as a business)" do
    sign_in users(:subscribed_business)
    get conversations_path
    assert_select "h2", developers(:prospect).name
  end

  test "you can view your conversations (as a developer)" do
    sign_in users(:prospect_developer)
    get conversations_path
    assert_select "h2", businesses(:subscriber).name
  end

  test "you can view your own conversation (as a business)" do
    conversation = conversations(:one)
    sign_in conversation.business.user

    get conversation_path(conversation)

    assert_response :ok
  end

  test "you can view your own conversation (as a developer)" do
    conversation = conversations(:one)
    sign_in conversation.developer.user

    get conversation_path(conversation)

    assert_response :ok
  end

  test "you can't view another's conversation" do
    conversation = conversations(:one)
    sign_in users(:empty)

    get conversation_path(conversation)

    assert_redirected_to root_path
  end

  test "unread notifictions are marked as read" do
    user = users(:subscribed_business)
    conversation = conversations(:one)
    business = conversation.business
    developer = conversation.developer

    create_message_and_notification!(developer:, business:, conversation:)
    refute Notification.last.read?

    sign_in user
    get conversation_path(conversation)

    assert Notification.last.read?
  end

  test "part-time plan subscribers can't message full-time seekers" do
    conversation = conversations(:one)
    sign_in conversation.business.user
    pay_subscriptions(:full_time).update!(processor_plan: BusinessSubscription::PartTime.new.plan)
    conversation.developer.role_type.update!(
      part_time_contract: false,
      full_time_contract: false,
      full_time_employment: true
    )

    get conversation_path(conversation)

    assert_select "h3", text: I18n.t("messages.upgrade_required.title")
  end
end
