module OpenStartup
  class StripeTransaction < ApplicationRecord
    self.table_name = "open_startup_stripe_transactions"

    enum transaction_type: {
      charge: "charge",
      contribution: "contribution",
      stripe_fee: "stripe_fee"
    }

    validates :stripe_id, presence: true
    validates :amount, numericality: {greater_than_or_equal_to: 0}
    validates :created, presence: true
    validates :description, presence: true
    validates :fee, numericality: {greater_than_or_equal_to: 0}
    validates :transaction_type, inclusion: {in: transaction_types.keys}
  end
end
