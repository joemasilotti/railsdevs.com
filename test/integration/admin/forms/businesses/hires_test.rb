require "test_helper"

class Admin::Forms::Businesses::HiresTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:admin)

    @business = businesses(:one)
    @form = forms_businesses_hires(:one)
  end

  test "views list of business forms" do
    get admin_forms_businesses_hires_path

    assert_select "a", @form.business.name
    assert_select "a", @form.developer_name
    assert_select "td", @form.employment_type.humanize
    assert_select "td", @form.start_date.to_formatted_s(:long)
  end

  test "views a business form" do
    get admin_forms_businesses_hire_path(@form)

    assert_select "a", @form.business.name
    assert_select "a", @form.business.user.email
    assert_select "a[href='mailto:#{@form.business.user.email}']"
    assert_select "p", @form.billing_address
    assert_select "dd", @form.developer_name
    assert_select "dd", @form.position
    assert_select "dd", @form.start_date.to_formatted_s(:long)
    assert_select "dd", @form.employment_type.humanize
    assert_select "dd", @form.feedback
  end
end
