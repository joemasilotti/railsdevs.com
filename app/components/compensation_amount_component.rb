class CompensationAmountComponent < ApplicationComponent
  attr_reader :amount, :title

  def initialize(min_amount:, max_amount:, title:)
    @min_amount = min_amount
    @max_amount = max_amount
    @title = title
  end

  def render?
    @min_amount.present?
  end
end
