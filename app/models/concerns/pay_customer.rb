module PayCustomer
  extend ActiveSupport::Concern

  included do
    pay_customer

    def pay_customer_name
      business&.name
    end
  end
end
