module Businesses
  module HiringInvoiceRequestsHelper
    def form_attributes
      {
        business: businesses(:one),
        billing_address: "123 Main St\nNew York, NY 10001",
        developer_name: "Core developer",
        annual_salary: 100_000,
        position: "Rails Developer",
        start_date: Date.today,
        employment_type: :full_time_employment,
        feedback: "Joe, you are doing a great job. Keep it up 🙏"
      }
    end
  end
end
