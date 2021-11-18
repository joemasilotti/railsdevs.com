require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  def setup
    @developer = users(:with_available_profile)
    @client = users(:client)
    @conversation = @client.hiring_leads.build(developer_id: @developer.id)
  end

  test "should be valid" do
    assert @conversation.valid?
  end

  test "should require developer id" do
    @conversation.developer_id = nil

    assert_not @conversation.valid?
  end

  test "should require client id" do
    @conversation.client_id = nil

    assert_not @conversation.valid?
  end

  test "should allow one conversation per set of users" do
    @conversation.save

    new_conversation = @client.hiring_leads.build(developer_id: @developer.id)
    assert_not new_conversation.valid?
  end

  test "should be accessible from client" do
    user = users(:with_available_profile)

    assert_not user.work_leads.empty?
  end

  test "should be accessible from developer" do
    user = users(:client_with_conversation)

    assert_not user.hiring_leads.empty?
  end

  test "should have access to user parents" do
    conversation = conversations(:one)
    client = users(:client_with_conversation)

    assert_equal conversation.client, client
    assert_equal conversation.developer, @developer
  end
end
