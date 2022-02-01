module OpenStartup
  class DashboardController < ApplicationController
    def show
      @metric = Metric.last
      @contributions = OpenStartup::Contribution.sum(:amount)
      @monthly_balances = MonthlyBalance.order(occurred_on: :desc)
    end
  end
end
