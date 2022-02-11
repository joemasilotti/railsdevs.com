module OpenStartup
  class MonthlyBalance < ApplicationRecord
    self.table_name = "open_startup_monthly_balances"

    validates :occurred_on, presence: true
    validates :revenue, numericality: {greater_than_or_equal_to: 0}
    validates :expenses, numericality: {greater_than_or_equal_to: 0}
    validates :contributions, numericality: {greater_than_or_equal_to: 0}

    def profit
      revenue - expenses - contributions
    end
  end
end
