require "test_helper"

class BusinessesTest < ActionDispatch::IntegrationTest
  include NotificationsHelper

  test "can build a new business" do
    sign_in users(:empty)
    get new_business_path
    assert_response :ok
  end

  test "redirect to edit if building an existing business" do
    user = users(:business)
    sign_in user

    get new_business_path

    assert_redirected_to edit_business_path(user.business)
  end

  test "cannot create new business if already has one" do
    sign_in users(:business)

    assert_no_difference "Business.count" do
      post businesses_path, params: valid_business_params
    end
  end

  test "redirect to the edit if they already have a business" do
    user = users(:business)
    sign_in user

    get new_business_path

    assert_redirected_to edit_business_path(user.business)
  end

  test "successful business creation" do
    user = users(:empty)
    sign_in user

    assert_difference ["Business.count", "Analytics::Event.count"], 1 do
      assert_sends_notification Admin::NewBusinessNotification do
        post businesses_path, params: valid_business_params
      end
    end

    last_event = Analytics::Event.last

    assert user.business.avatar.attached?
    assert_redirected_to last_event
    assert_equal Analytics::Event.last.url, developers_path

    follow_redirect!

    assert_redirected_to last_event.url

    follow_redirect!

    assert_not_nil flash[:event]
    assert_not_nil flash[:notice]
  end

  test "successful business creation with a stored location" do
    developer = developers(:one)

    sign_in users(:empty)
    post developer_messages_path(developer)
    assert_redirected_to new_business_path

    post businesses_path, params: valid_business_params
    assert_redirected_to Analytics::Event.last
    assert_equal Analytics::Event.last.url, developer_messages_path(developer)
  end

  test "successful edit to business" do
    sign_in users(:business)
    business = businesses(:one)

    get edit_business_path(business)
    assert_select "form"
    assert_select "#business_avatar_hidden"

    patch business_path(business), params: {
      business: {
        contact_name: "New Owner Name",
        contact_role: "New Role",
        website: "http://www.newwebsite.com"
      }
    }
    assert_redirected_to developers_path
    follow_redirect!

    assert_equal "New Owner Name", business.reload.name
    assert_equal "New Role", business.reload.contact_role
    assert_equal "http://www.newwebsite.com", business.reload.website
  end

  test "invalid profile creation" do
    sign_in users(:empty)

    assert_no_difference "Business.count" do
      post businesses_path, params: {
        business: {
          contact_name: "Business"
        }
      }
    end
  end

  test "can edit own business" do
    sign_in users(:business)
    business = businesses(:one)

    get edit_business_path(business)
    assert_select "form"
    assert_select "#business_avatar_hidden"

    patch business_path(business), params: {
      business: {
        contact_name: "New Name",
        contact_role: "New Role",
        website: "http://www.newwebsite.com"
      }
    }
    assert_redirected_to developers_path
    assert_equal "New Name", business.reload.name
  end

  test "cannot edit another business" do
    sign_in users(:business)
    business = businesses(:subscriber)

    get edit_business_path(business)
    assert_redirected_to root_path

    assert_no_changes "business.contact_name" do
      patch business_path(business), params: {
        business: {
          contact_name: "New Name"
        }
      }
    end
    assert_redirected_to root_path
  end

  test "can update email notification preferences with an active business subscription" do
    user = users(:subscribed_business)
    business = user.business
    sign_in user

    patch business_path(business), params: {
      business: {
        developer_notifications: :daily
      }
    }
    assert business.reload.daily_developer_notifications?
  end

  test "cannot update email notification preferences without a subscription" do
    user = users(:business)
    business = user.business
    sign_in user

    patch business_path(business), params: {
      business: {
        developer_notifications: :daily
      }
    }
    assert business.reload.no_developer_notifications?
  end

  def valid_business_params
    {
      business: {
        contact_name: "Business Owner",
        contact_role: "Director",
        company: "Business, LLC",
        bio: "We're in the business for business.",
        avatar: fixture_file_upload("basecamp.png", "image/png"),
        website: "http://www.example.com"
      }
    }
  end

  test "can see own business profile when invisible" do
    business = businesses(:one)
    business.update(invisible: true)
    sign_in business.user

    get business_path(business)

    assert_response :ok
  end
end
