require "test_helper"

class Admin::PromptsTest < ActionDispatch::IntegrationTest
  class BasicBehavior < Admin::PromptsTest
    test "should show an empty state on index when there's no prompts" do
      sign_in users(:admin)
      Admin::Prompt.delete_all
      assert_equal 0, Admin::Prompt.count

      get root_path
      assert_select "a[href='#{admin_prompts_path}']"

      get admin_prompts_path
      assert_select "#empty-state"
    end
  end

  class Authorization < Admin::PromptsTest
    test "must be signed in to see the prompts" do
      get admin_prompts_path
      assert_redirected_to new_user_registration_path
    end

    test "must be an admin to see the prompts" do
      sign_in users(:empty)
      get admin_prompts_path
      assert_redirected_to root_path
    end

    test "must be signed in to see the form for an new prompt" do
      get new_admin_prompt_path
      assert_redirected_to new_user_registration_path
    end

    test "must be an admin to see the form for a new prompt" do
      sign_in users(:empty)
      get new_admin_prompt_path
      assert_redirected_to root_path
    end

    test "must be signed in to create a new prompt" do
      post admin_prompts_path, params: {prompt: {name: "Test name"}}
      assert_redirected_to new_user_registration_path
    end

    test "must be an admin to create a new prompt" do
      sign_in users(:empty)
      post admin_prompts_path, params: {prompt: {name: "Test name"}}
      assert_redirected_to root_path
    end

    test "must be signed in to see the form to edit a prompt" do
      get edit_admin_prompt_path(admin_prompts(:one))
      assert_redirected_to new_user_registration_path
    end

    test "must be an admin to see the form to edit a prompt" do
      sign_in users(:empty)
      get edit_admin_prompt_path(admin_prompts(:one))
      assert_redirected_to root_path
    end

    test "must be signed in to update a prompt" do
      patch admin_prompt_path(admin_prompts(:one)), params: {prompt: {name: "Test name"}}
      assert_redirected_to new_user_registration_path
    end

    test "must be an admin to update a prompt" do
      sign_in users(:empty)
      patch admin_prompt_path(admin_prompts(:one)), params: {prompt: {name: "Test name"}}
      assert_redirected_to root_path
    end
  end
end
