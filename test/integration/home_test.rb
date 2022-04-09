require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest
  include MetaTagsHelper

  test "shows developer profiles" do
    get root_path
    assert_select "h2", developers(:one).hero
  end

  test "custom meta tags are rendered" do
    get root_path

    assert_title_contains I18n.t("home.show.title_og")
    assert_description_contains I18n.t("home.show.description_og")
  end
end
