require "test_helper"

class BlocksTest < ActionDispatch::IntegrationTest
  setup do
    @conversation = conversations(:one)
    @developer = @conversation.developer
    @business = @conversation.business
  end

  test "must be signed in" do
    get new_conversation_block_path(@conversation)
    post conversation_block_path(@conversation)
    assert_redirected_to new_user_session_path
  end

  test "the developer can block the conversation" do
    sign_in @developer.user

    get new_conversation_block_path(@conversation)
    post conversation_block_path(@conversation)

    assert_not_nil @conversation.reload.developer_blocked_at
    assert_redirected_to root_path
  end

  test "the business can block the conversation" do
    sign_in @business.user

    get new_conversation_block_path(@conversation)
    post conversation_block_path(@conversation)

    assert_not_nil @conversation.reload.business_blocked_at
    assert_redirected_to root_path
  end

  test "no one else can contribute to the conversation" do
    sign_in users(:empty)

    get new_conversation_block_path(@conversation)
    post conversation_block_path(@conversation)

    assert_nil @conversation.reload.developer_blocked_at
    assert_nil @conversation.reload.business_blocked_at
    assert_redirected_to root_path
  end
end
