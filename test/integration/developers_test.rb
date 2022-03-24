require "test_helper"

class DevelopersTest < ActionDispatch::IntegrationTest
  include MetaTagsHelper
  include PagyHelper

  test "can view visible developer profiles" do
    get developers_path

    assert_select "h2", developers(:available).hero
    assert_select "h2", developers(:unavailable).hero
    assert_select "h2", text: developers(:invisible).hero, count: 0
  end

  test "custom meta tags are rendered" do
    get developers_path
    assert_title_contains "Hire Ruby on Rails developers"
    assert_description_contains "looking for their"
  end

  test "can't view developer with invisible profile" do
    dev = developers(:invisible)
    get developer_path(dev)
    assert_redirected_to root_path
  end

  test "can see own developer profile when invisible" do
    sign_in users(:with_invisible_profile)
    one = developers :invisible

    get developer_path(one)
    assert_response :ok
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

  test "developers can be filtered by role level" do
    get developers_path(role_levels: ["junior", "mid", "senior"])

    assert_select "input[checked][type=checkbox][value=junior][name='role_levels[]']"
    assert_select "input[checked][type=checkbox][value=mid][name='role_levels[]']"
    assert_select "input[checked][type=checkbox][value=senior][name='role_levels[]']"
    assert_select "h2", developers(:with_junior_role_level).hero
    assert_select "h2", developers(:with_mid_role_level).hero
    assert_select "h2", developers(:with_senior_role_level).hero
    assert_select "h2", text: developers(:with_principal_role_level).hero, count: 0
    assert_select "h2", text: developers(:with_c_type_role_level).hero, count: 0
  end

  test "developers can be filtered by hero or bio" do
    developer = developers(:complete)
    get developers_path(search_query: "#{developer.bio} #{developer.hero}")

    assert_select "h2", developers(:complete).hero
  end

  test "developers not interested in work can be shown" do
    get developers_path(include_not_interested: true)

    assert_select "input[checked][type=checkbox][name='include_not_interested']"
    assert_select "h2", developers(:with_not_interested_search_status).hero
  end

  test "paginating filtered developers respects the filters" do
    with_pagy_default_items(1) do
      get developers_path(sort: :availability)
      assert_select "#developers h2", count: 1
      assert_select "#mobile-filters h2", count: 1
      assert_select "a[href=?]", "/developers?sort=availability&page=2"
    end
  end

  test "cannot create new profile if already has one" do
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
      params[:developer][:role_level_attributes] = {senior: true}
      post developers_path, params:
    end

    assert user.developer.role_type.part_time_contract?
    assert user.developer.role_level.senior?
    assert user.developer.avatar.attached?
  end

  test "custom develper meta tags are rendered" do
    developer = developers(:available)

    get developer_path(developer)

    assert_title_contains developer.hero
    assert_description_contains developer.bio
  end

  test "edit with nested attributes" do
    user = users(:with_available_profile)
    sign_in user

    patch developer_path(user.developer), params: {
      developer: {
        role_type_attributes: {
          part_time_contract: true
        },
        role_level_attributes: {
          junior: true,
          mid: true
        }
      }
    }

    assert user.developer.reload.role_type.part_time_contract?
    assert user.developer.reload.role_level.junior?
    assert user.developer.reload.role_level.mid?
  end

  test "successful edit to profile" do
    sign_in users(:with_available_profile)
    developer = developers :available

    get edit_developer_path(developer)
    assert_select "form"
    assert_select "#developer_avatar_hidden"
    assert_select "#developer_cover_image_hidden"

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
    assert_select "#developer_avatar_hidden"
    assert_select "#developer_cover_image_hidden"

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
