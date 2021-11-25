class CompensationAmountComponent < ApplicationComponent
  attr_reader :min_amount, :max_amount, :suffix, :title

  def initialize(min_amount:, max_amount:, suffix:, title:)
    @min_amount = min_amount
    @max_amount = max_amount
    @suffix = suffix
    @title = title
  end

  def render?
    @min_amount.present?
  end
end
