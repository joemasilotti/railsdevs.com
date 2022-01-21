class IncomeReport
  def expenses
    get_table("expenses")
  end

  def total_expenses
    expenses["data"].sum { |e| e["total"] }
  end

  def revenue
    get_table("revenue")
  end

  def total_revenue
    revenue["data"].sum { |e| e["total"] }
  end

  def total
    total_revenue - total_expenses
  end

  def overview
    total_data = expenses["data"].group_by { |e| e["date"].to_date.strftime("%B, %Y") }.merge(revenue["data"].group_by { |e| e["date"].to_date.strftime("%B, %Y") })

    total_data.map do |e, i|
      exp_total = i.sum { |y| (y["description"] ? y["total"] : 0) }
      rev_total = i.sum { |y| (y["source"] ? y["total"] : 0) }

      {month: e, expense_total: exp_total, revenue_total: rev_total, total: (exp_total - rev_total)}
    end
  end

  private

  def get_table(table)
    YAML.safe_load(File.read("#{Rails.root}/data/financials.yml"))["financials"][table]
  end
end
