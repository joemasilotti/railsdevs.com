class CompensationAmountComponent < ApplicationComponent
  attr_reader :amount, :title

  def initialize(amount:, title:)
    @amount = amount
    @title = title
  end

  def render?
    @amount.present?
  end
end
