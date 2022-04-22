require "test_helper"

class ConversationsTest < ActionDispatch::IntegrationTest
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
    user = users(:prospect_developer)
    developer = user.developer
    business = businesses(:subscriber)
    conversation = conversations(:one)
    Message.create!(developer:, business:, body: "Hi!", sender: business, conversation:)
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
