class FinancialsController < ApplicationController
  def show
    @report = IncomeReport.new
  end
end
