require "test_helper"

class Admin::ConversationsTest < ActionDispatch::IntegrationTest
  test "must be signed in" do
    get admin_conversations_path
    assert_redirected_to new_user_session_path
  end

  test "must be an admin" do
    sign_in users(:empty)
    get admin_conversations_path
    assert_redirected_to root_path
  end

  test "lists conversations" do
    sign_in users(:admin)
    get admin_conversations_path

    assert_select "h1", I18n.t("admin.conversations.index.title")
    assert_select "td", text: "#{businesses(:subscriber).company} (#{businesses(:subscriber).name})"
    assert_select "td", text: developers(:prospect).name
  end

  test "lists developer conversations" do
    sign_in users(:admin)
    developer = developers(:prospect)

    get admin_developer_conversations_path(developer)

    assert_select "h1", text: "#{developer.name}'s conversations" do
      assert_select "a[href=?]", developer_path(developer), text: developer.name
    end
  end

  test "lists business conversations" do
    sign_in users(:admin)
    business = businesses(:subscriber)

    get admin_business_conversations_path(business)

    assert_select "h1", text: "#{business.company}'s conversations" do
      assert_select "a[href=?]", business_path(business), text: business.company
    end
  end
end
