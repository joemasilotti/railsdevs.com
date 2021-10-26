require "test_helper"

class DevelopersTest < ActionDispatch::IntegrationTest
  test "can view developer profiles" do
    @one = developers :one
    @two = developers :two

    get root_path

    assert_select "h2", @one.hero
    assert_select "h2", @two.hero
  end

  test "succesful profile creation" do
    assert_difference "Developer.count", 1 do
      post developers_path, params: {
        developer: {
          name: "Developer",
          email: "dev@example.com",
          available_on: Date.yesterday,
          hero: "A developer",
          bio: "I develop."
        }
      }
    end
  end

  test "invalid profile creation" do
    assert_no_difference "Developer.count" do
      post developers_path, params: {
        developer: {
          name: "Developer"
        }
      }
    end
  end
end
