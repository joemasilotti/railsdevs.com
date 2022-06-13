require "test_helper"

class ColdMessagesTest < ActionDispatch::IntegrationTest
  include NotificationsHelper
  include PayHelper
  include SubscriptionsHelper

  setup do
    @developer = developers(:one)
    @business = businesses(:subscriber)
  end

  test "must be signed in" do
    post developer_messages_path(@developer)
    assert_redirected_to new_user_session_path
  end

  test "must have a business profile" do
    sign_in users(:empty)

    get new_developer_message_path(@developer)
    assert_redirected_to new_business_path

    post developer_messages_path(@developer)
    assert_redirected_to new_business_path
  end

  test "must have an active business subscription" do
    sign_in businesses(:one).user
    get new_developer_message_path(@developer)
    assert_redirected_to pricing_path
  end

  test "stores the location if no active business subscription" do
    sign_in businesses(:one).user
    get new_developer_message_path(@developer)
    assert_equal session["user_return_to"], new_developer_message_path(@developer)
  end

  test "a business can start a new conversation" do
    sign_in @business.user
    get new_developer_message_path(@developer)
    assert_select "form[action=?]", developer_messages_path(@developer)
  end

  test "a business sees the hiring fee agreement checkbox" do
    sign_in @business.user
    get new_developer_message_path(@developer)

    assert_select "input[type=checkbox][name='message[hiring_fee_agreement]']"
  end

  test "a legacy business do not see the hiring fee agreement checkbox" do
    sign_in @business.user
    update_subscription(:legacy)
    get new_developer_message_path(@developer)

    assert_select "input[type=checkbox][name='message[hiring_fee_agreement]']", count: 0
  end

  test "a business can create a new conversation" do
    sign_in @business.user

    assert_difference "Message.count", 1 do
      assert_difference "Conversation.count", 1 do
        assert_sends_notification Admin::NewConversationNotification do
          post developer_messages_path(@developer), params: message_params
        end
      end
    end

    assert_redirected_to conversation_path(Conversation.last)
    follow_redirect!
    assert_select "h1", text: /^Conversation/
  end

  test "starting an existing conversation redirects to the conversation" do
    sign_in @business.user
    conversation = Conversation.create!(developer: @developer, business: @business)

    get new_developer_message_path(@developer)

    assert_redirected_to conversation_path(conversation)
  end

  test "part-time plan subscribers can't message full-time seekers" do
    sign_in @business.user
    update_subscription(:part_time)
    @developer.role_type.update!(
      part_time_contract: false,
      full_time_contract: false,
      full_time_employment: true
    )

    get new_developer_message_path(@developer)

    assert_select "h3", text: I18n.t("businesses.upgrade_required_component.title.upgrade")
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

  test "unaccepted terms of service renders the error message" do
    sign_in @business.user

    assert_no_difference "Message.count" do
      assert_no_difference "Conversation.count" do
        post developer_messages_path(@developer), params: {
          message: {
            body: "Hello!",
            hiring_fee_agreement: false
          }
        }
      end
    end

    assert_response :unprocessable_entity
    assert_select "li", text: "Hiring fee agreement must be accepted"
  end

  def message_params
    {
      message: {
        body: "Hello!"
      }
    }
  end
end
