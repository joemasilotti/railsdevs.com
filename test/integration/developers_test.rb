require "test_helper"

class DevelopersTest < ActionDispatch::IntegrationTest
  include DevelopersHelper
  include MetaTagsHelper
  include NotificationsHelper
  include PagyHelper

  test "can view developer profiles" do
    get developers_path
    assert_select "h2", developers(:one).hero
  end

  test "no developers produce empty state" do
    Developer.destroy_all
    get developers_path
    assert_select "h3", I18n.t("developers.index.empty_state.title")
  end

  test "custom meta tags are rendered" do
    get developers_path
    assert_title_contains "Hire Ruby on Rails developers"
    assert_description_contains "looking for their"
  end

  test "can't view developer with invisible profile" do
    developer = create_developer(search_status: :invisible)
    get developer_path(developer)
    assert_redirected_to root_path
  end

  test "can see own developer profile when invisible" do
    developer = create_developer(search_status: :invisible)
    sign_in developer.user

    get developer_path(developer)

    assert_response :ok
  end

  test "admin can see invisible developer profile" do
    developer = create_developer(search_status: :invisible)
    user = users(:admin)
    sign_in user

    get developer_path(developer)

    assert_response :ok
  end

  test "developers are sorted newest first" do
    create_developer(hero: "Oldest")
    create_developer(hero: "Newest")

    get developers_path

    assert_select "button.font-medium[value=newest]"
    assert response.body.index("Newest") < response.body.index("Oldest")
  end

  test "developers can be sorted by availability" do
    create_developer(hero: "Available", available_on: Date.yesterday)

    get developers_path(sort: :availability)

    assert_select "button.font-medium[value=availability]"
    assert_select "h2", "Available"
  end

  test "developers can be filtered by time zone" do
    create_developer(hero: "Pacific", location_attributes: {utc_offset: PACIFIC_UTC_OFFSET})

    get developers_path(utc_offsets: [PACIFIC_UTC_OFFSET])

    assert_select "input[checked][type=checkbox][value=#{PACIFIC_UTC_OFFSET}][name='utc_offsets[]']"
    assert_select "h2", "Pacific"
  end

  test "developers can be filtered by role type" do
    create_developer(hero: "Part-time", role_type_attributes: {part_time_contract: true})

    get developers_path(role_types: ["part_time_contract"])

    assert_select "input[checked][type=checkbox][value=part_time_contract][name='role_types[]']"
    assert_select "h2", "Part-time"
  end

  test "developers can be filtered by role level" do
    create_developer(hero: "Mid", role_level_attributes: {mid: true})

    get developers_path(role_levels: ["mid"])

    assert_select "input[checked][type=checkbox][value=mid][name='role_levels[]']"
    assert_select "h2", "Mid"
  end

  test "developers can be filtered by hero or bio" do
    create_developer(hero: "OSS lover")
    get developers_path(search_query: "OSS")
    assert_select "h2", "OSS lover"
  end

  test "developers not interested in work can be shown" do
    create_developer(hero: "Not interested", search_status: :not_interested)

    get developers_path(include_not_interested: true)

    assert_select "input[checked][type=checkbox][name='include_not_interested']"
    assert_select "h2", "Not interested"
  end

  test "mobile filtering" do
    get developers_path

    assert_select "h2", text: developers(:one).hero, count: 1
    assert_select "form#developer-filters-mobile"
    developers(:one).role_level.update!(junior: false)

    get developers_path, params: {
      "developer-filters-mobile": {
        role_levels: [:junior]
      }
    }

    assert_select "h2", text: developers(:one).hero, count: 0
  end

  test "paginating filtered developers respects the filters" do
    developers(:prospect).update!(available_on: Date.yesterday, search_status: :open)

    with_pagy_default_items(1) do
      get developers_path(sort: :availability)
      assert_select "#developers h2", count: 1
      assert_select "#mobile-filters h2", count: 1
      assert_select "a[href=?]", "/developers?sort=availability&page=2"
    end
  end

  test "cannot create new profile if already has one" do
    sign_in users(:developer)

    assert_no_difference "Developer.count" do
      post developers_path, params: valid_developer_params
    end
  end

  test "redirect to the edit profile when they try to enter developers/new, if they already have a profile" do
    user = users(:developer)
    sign_in user

    get new_developer_path

    assert_redirected_to edit_developer_path(user.developer)
  end

  test "successful profile creation" do
    sign_in users(:empty)

    assert_difference ["Developer.count", "Analytics::Event.count"], 1 do
      assert_sends_notification Admin::NewDeveloperNotification do
        post developers_path, params: valid_developer_params
      end
    end

    last_event = Analytics::Event.last

    assert_redirected_to analytics_event_path(last_event)

    follow_redirect!

    assert_redirected_to last_event.url

    follow_redirect!

    assert_not_nil flash[:event]
    assert_not_nil flash[:notice]
  end

  test "create with nested attributes" do
    user = users(:empty)
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
    developer = developers(:one)

    get developer_path(developer)

    assert_title_contains developer.hero
    assert_description_contains developer.bio
  end

  test "developer bios are stripped of HTML tags and new lines are converted to <p> tags" do
    developer = developers(:one)
    developer.update!(bio: "Line one\n\nLine two\n\n<h1>Header</h1>")

    get developer_path(developer)

    assert_select "p", text: "Line one"
    assert_select "p", text: "Line two"
    assert_select "p", text: "Header"
  end

  test "successful edit to profile" do
    sign_in users(:developer)
    developer = developers(:one)

    get edit_developer_path(developer)
    assert_select "form"
    assert_select "#developer_avatar_hidden"
    assert_select "#developer_cover_image_hidden"

    assert_sends_notification Admin::PotentialHireNotification, to: users(:admin) do
      patch developer_path(developer), params: {
        developer: {
          name: "New Name",
          search_status: "not_interested"
        }
      }
    end
    assert_redirected_to developer_path(developer)
    follow_redirect!

    assert_equal "New Name", developer.reload.name
  end

  test "edit with nested attributes" do
    user = users(:developer)
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

  test "invalid profile creation" do
    sign_in users(:empty)

    assert_no_difference "Developer.count" do
      post developers_path, params: {
        developer: {
          name: "Developer"
        }
      }
    end
  end

  test "can edit own profile" do
    sign_in users(:developer)
    developer = developers(:one)

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
    sign_in users(:developer)
    developer = developers(:prospect)

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
    sign_in users(:empty)

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
