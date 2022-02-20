require "test_helper"

class DevelopersTest < ActionDispatch::IntegrationTest
  include PagyHelper

  test "can view developer profiles" do
    one = developers :available
    two = developers :unavailable

    get developers_path

    assert_select "h2", one.hero
    assert_select "h2", two.hero
  end

  test "developers are sorted newest first" do
    one = developers :available
    two = developers :unavailable

    get developers_path

    assert_select "button.font-medium[value=newest]"
    assert response.body.index(one.hero) < response.body.index(two.hero)
  end

  test "developers can be sorted by availability" do
    get developers_path(sort: :availability)

    assert_select "button.font-medium[value=availability]"
    assert_select "h2", developers(:available).hero
    assert_select "h2", text: developers(:with_conversation).hero, count: 0
  end

  test "developers can be filtered by time zone" do
    get developers_path(utc_offsets: [PACIFIC_UTC_OFFSET])

    assert_select "input[checked][type=checkbox][value=#{PACIFIC_UTC_OFFSET}][name='utc_offsets[]']"
    assert_select "h2", developers(:unavailable).hero
    assert_select "h2", text: developers(:available).hero, count: 0
  end

  test "developers can be filtered by role type" do
    get developers_path(role_types: ["part_time_contract", "full_time_contract"])

    assert_select "input[checked][type=checkbox][value=part_time_contract][name='role_types[]']"
    assert_select "input[checked][type=checkbox][value=full_time_contract][name='role_types[]']"
    assert_select "h2", developers(:with_full_time_contract).hero
    assert_select "h2", developers(:with_part_time_contract).hero
    assert_select "h2", text: developers(:with_full_time_employment).hero, count: 0
  end

  test "paginating filtered developers respects the filters" do
    with_pagy_default_items(1) do
      get developers_path(sort: :availability)
      assert_select "h2", count: 1
      assert_select "a[href=?]", "/developers?sort=availability&page=2"
    end
  end

  test "cannot create new proflie if already has one" do
    sign_in users(:with_available_profile)

    assert_no_difference "Developer.count" do
      post developers_path, params: valid_developer_params
    end
  end

  test "redirect to the edit profile when they try to enter developers/new, if they already have a profile" do
    user = users(:with_available_profile)
    sign_in user

    get new_developer_path

    assert_redirected_to edit_developer_path(user.developer)
  end

  test "successful profile creation" do
    sign_in users(:without_profile)

    assert_difference ["Developer.count", "Analytics::Event.count"], 1 do
      post developers_path, params: valid_developer_params
    end
    assert_redirected_to analytics_event_path(Analytics::Event.last)
    assert_equal Analytics::Event.last.url, developer_path(Developer.last)
  end

  test "create with nested attributes" do
    user = users(:without_profile)
    sign_in user

    assert_difference "Developer.count", 1 do
      params = valid_developer_params
      params[:developer][:role_type_attributes] = {part_time_contract: true}
      post developers_path, params:
    end

    assert user.developer.role_type.part_time_contract?
    assert_equal "lovelace.jpg", user.developer.avatar.filename.to_s
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
        bio: "I develop.",
        avatar: fixture_file_upload("lovelace.jpg", "image/jpeg"),
        cover_image: fixture_file_upload("mountains.jpg", "image/jpeg"),
        location_attributes: {
          city: "City"
        }
      }
    }
  end
end
