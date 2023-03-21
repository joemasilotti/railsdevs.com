require "test_helper"

class Forms::Businesses::HiresTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:business)
  end

  test "creates a Hire form" do
    assert_changes "Forms::Businesses::Hire.count", 1 do
      post forms_businesses_hires_path(attributes)
    end

    assert_equal "John Doe", Forms::Businesses::Hire.last.developer_name
  end

  test "validates a Hire form" do
    assert_no_changes "Forms::Businesses::Hire.count" do
      post forms_businesses_hires_path(forms_businesses_hire: {developer_name: ""})
    end

    assert_response :unprocessable_entity
  end

  def attributes
    {
      forms_businesses_hire: {
        billing_address: "123 Main St\nNew York, NY 10001",
        developer_name: 'John Doe',
        position: 'Rails Developer',
        start_date: Date.today,
        annual_salary: 80_000,
        employment_type: :full_time_employment,
        feedback: 'John is the perfect candidate!'
      }
    }
  end
end
