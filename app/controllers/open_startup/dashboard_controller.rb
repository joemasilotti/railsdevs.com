module OpenStartup
  class DashboardController < ApplicationController
    def show
      @metric = Metric.most_recent
      @contributions = OpenStartup::Contribution.sum(:amount)
      @monthly_balances = MonthlyBalance.order(occurred_on: :desc)
    end
  end
end
