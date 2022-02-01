module OpenStartup
  class Transaction < ApplicationRecord
    self.table_name = "open_startup_transactions"

    enum transaction_type: {
      expense: 1,
      contribution: 2
    }

    validates :occurred_on, presence: true
    validates :description, presence: true
    validates :amount, numericality: {greater_than: 0}
    validates :transaction_type, inclusion: {in: transaction_types.keys}
  end
end
