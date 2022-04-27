require "test_helper"

class ColdMessagesTest < ActionDispatch::IntegrationTest
  include PayHelper

  setup do
    @developer = developers(:one)
    @business = businesses(:subscriber)
  end

  test "must be signed in" do
    post developer_messages_path(@developer)
    assert_redirected_to new_user_registration_path
  end

  test "a business can start a new conversation" do
    sign_in @business.user
    get new_developer_message_path(@developer)
    assert_select "form[action=?]", developer_messages_path(@developer)
  end

  test "unauthorized users are redirected" do
    sign_in users(:empty)
    get new_developer_message_path(@developer)
    assert_redirected_to new_business_path
  end

  test "part-time plan subscribers can't message full-time seekers" do
    sign_in @business.user
    pay_subscriptions(:full_time).update!(processor_plan: BusinessSubscription::PartTime.new.plan)
    @developer.role_type.update!(
      part_time_contract: false,
      full_time_contract: false,
      full_time_employment: true
    )

    get new_developer_message_path(@developer)

    assert_select "h3", text: I18n.t("messages.upgrade_required.title")
  end

  test "a business sees the hiring fee agreement checkbox" do
    sign_in @business.user
    get new_developer_message_path(@developer)

    assert_select "input[type=checkbox][name='message[hiring_fee_agreement]']"
  end

  test "a legacy business do not see the hiring fee agreement checkbox" do
    sign_in @business.user
    pay_subscriptions(:full_time).update!(processor_plan: BusinessSubscription::Legacy.new.plan)
    get new_developer_message_path(@developer)

    assert_select "input[type=checkbox][name='message[hiring_fee_agreement]']", count: 0
  end

  test "a business can create a new conversation" do
    sign_in @business.user

    assert_difference "Message.count", 1 do
      assert_difference "Conversation.count", 1 do
        post developer_messages_path(@developer), params: message_params
      end
    end

    assert_redirected_to conversation_path(Conversation.last)
    follow_redirect!
    assert_select "h1", text: /^Conversation/
  end

  test "unauthorized users are redirected when sending a message" do
    sign_in users(:empty)
    post developer_messages_path(@developer), params: message_params
    assert_redirected_to new_business_path
  end

  test "an invalid message re-renders the form" do
    sign_in @business.user

    assert_no_difference "Message.count" do
      assert_no_difference "Conversation.count" do
        post developer_messages_path(@developer), params: {message: {body: nil}}
      end
    end

    assert_response :unprocessable_entity
  end

  def message_params
    {
      message: {
        body: "Hello!"
      }
    }
  end
end
