require "test_helper"

class Businesses::HiringInvoiceRequestsTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:business)
  end

  test "creates a HiringInvoiceRequest" do
    assert_changes "Businesses::HiringInvoiceRequest.count", 1 do
      post businesses_hiring_invoice_requests_path(attributes)
    end

    assert_equal "John Doe", Businesses::HiringInvoiceRequest.last.developer_name
  end

  test "validates a HiringInvoiceRequest" do
    assert_no_changes "Businesses::HiringInvoiceRequest.count" do
      post businesses_hiring_invoice_requests_path(businesses_hiring_invoice_request: {developer_name: ""})
    end

    assert_response :unprocessable_entity
  end

  def attributes
    {
      businesses_hiring_invoice_request: {
        billing_address: "123 Main St\nNew York, NY 10001",
        developer_name: "John Doe",
        position: "Rails Developer",
        start_date: Date.today,
        annual_salary: 80_000,
        employment_type: :full_time_employment,
        feedback: "John is the perfect candidate!"
      }
    }
  end
end
