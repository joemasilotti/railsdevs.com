module OpenStartup
  class ExpensesController < ApplicationController
    def index
      @expenses = Expense.order(occurred_on: :desc)
    end
  end
end
