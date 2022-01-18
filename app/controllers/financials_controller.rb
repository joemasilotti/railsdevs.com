class FinancialsController < ApplicationController
  def show
    @expenses = get_table("expenses")
    @total_expenses = @expenses["data"].sum { |e| e["total"] }
    @revenue = get_table("revenue")
    @total_revenue = @revenue["data"].sum { |e| e["total"] }
    @overview = overview_data
    @total = @total_revenue - @total_expenses
  end

  private

  def overview_data
    @expenses["data"].group_by { |e| e["date"].to_date.strftime("%B, %Y") }.merge(@revenue["data"].group_by { |e| e["date"].to_date.strftime("%B, %Y") }).map { |e, i|
      {month: e, expense_total: (i.sum { |y| (y["description"] ? y["total"] : 0) }), revenue_total: (i.sum { |y| (y["source"] ? y["total"] : 0) })}
    }.map { |e| {month: e[:month], expense_total: e[:expense_total], revenue_total: e[:revenue_total], total: (e[:revenue_total] - e[:expense_total])} }
  end

  def get_table(table)
    YAML.safe_load(File.read("#{Rails.root}/data/financials.yml"))["financials"][table]
  end
end
