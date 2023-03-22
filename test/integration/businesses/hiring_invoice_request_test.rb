require "test_helper"

class Businesses::HiringInvoiceRequestsTest < ActionDispatch::IntegrationTest
  include Businesses::HiringInvoiceRequestsHelper

  setup do
    sign_in users(:business)
  end

  test "creates a HiringInvoiceRequest" do
    assert_changes "Businesses::HiringInvoiceRequest.count", 1 do
      post businesses_hiring_invoice_requests_path(businesses_hiring_invoice_request: form_attributes)
    end

    assert_equal "Core developer", Businesses::HiringInvoiceRequest.last.developer_name
  end

  test "validates a HiringInvoiceRequest" do
    assert_no_changes "Businesses::HiringInvoiceRequest.count" do
      post businesses_hiring_invoice_requests_path(businesses_hiring_invoice_request: {developer_name: ""})
    end

    assert_response :unprocessable_entity
  end
end
