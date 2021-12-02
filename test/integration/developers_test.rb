require "test_helper"

class DevelopersTest < ActionDispatch::IntegrationTest
  test "can view developer profiles" do
    one = developers :available
    two = developers :unavailable

    get developers_path

    assert_select "h2", one.hero
    assert_select "h2", two.hero
  end

  test "cannot create new proflie if already has one" do
    sign_in users(:with_available_profile)

    assert_no_difference "Developer.count" do
      post developers_path, params: {
        developer: {
          name: "Developer",
          available_on: Date.yesterday,
          hero: "A developer",
          bio: "I develop."
        }
      }
    end
  end

  test "redirect to the edit profile when they try to enter developers/new, if they already have a profile" do
    sign_in users(:with_available_profile)

    get new_developer_path

    assert_redirected_to edit_developer_path(users(:with_available_profile).developer)
  end

  test "successful profile creation" do
    sign_in users(:without_profile)

    assert_difference "Developer.count", 1 do
      post developers_path, params: valid_developer_params
    end
  end

  test "create with nested attributes" do
    user = users(:without_profile)
    sign_in user

    assert_difference "Developer.count", 1 do
      params = valid_developer_params
      params[:developer][:role_type_attributes] = {part_time_contract: true}
      post developers_path, params: params
    end

    assert user.developer.role_type.part_time_contract?
  end

  test "edit with nested attributes" do
    user = users(:with_available_profile)
    sign_in user

    patch developer_path(user.developer), params: {
      developer: {
        role_type_attributes: {
          part_time_contract: true
        }
      }
    }

    assert user.developer.reload.role_type.part_time_contract?
  end

  test "successful profile creation sends a notification to the admin" do
    sign_in users(:without_profile)

    assert_changes "Notification.count", 1 do
      post developers_path, params: valid_developer_params
    end
  end

  test "successful edit to profile" do
    sign_in users(:with_available_profile)
    developer = developers :available

    get edit_developer_path(developer)
    assert_select "form"

    patch developer_path(developer), params: {
      developer: {
        name: "New Name"
      }
    }
    assert_redirected_to developer_path(developer)
    follow_redirect!

    assert_equal "New Name", developer.reload.name
  end

  test "invalid profile creation" do
    sign_in users(:without_profile)

    assert_no_difference "Developer.count" do
      post developers_path, params: {
        developer: {
          name: "Developer"
        }
      }
    end
  end

  test "can edit own profile" do
    sign_in users(:with_available_profile)
    developer = developers :available

    get edit_developer_path(developer)
    assert_select "form"

    patch developer_path(developer), params: {
      developer: {
        name: "New Name"
      }
    }
    assert_redirected_to developer_path(developer)
    assert_equal "New Name", developer.reload.name
  end

  test "cannot edit another developer's profile" do
    sign_in users(:with_available_profile)
    developer = developers :unavailable

    get edit_developer_path(developer)
    assert_redirected_to root_path

    assert_no_changes "developer.name" do
      patch developer_path(developer), params: {
        developer: {
          name: "New Name"
        }
      }
    end
    assert_redirected_to root_path
  end

  test "invalid form changes label color" do
    sign_in users(:without_profile)

    post developers_path, params: {
      developer: {
        name: ""
      }
    }
    assert_select %(div.text-red-600 label[for="developer_name"])
    assert_select %(div.text-red-600 label[for="developer_hero"])
    assert_select %(div.text-red-600 label[for="developer_bio"])
  end

  test "pagination" do
    get developers_path
    assert_select "#developers"
  end

  def valid_developer_params
    {
      developer: {
        name: "Developer",
        available_on: Date.yesterday,
        hero: "A developer",
        bio: "I develop."
      }
    }
  end
end
