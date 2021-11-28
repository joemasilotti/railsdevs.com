class CompensationAmountComponent < ApplicationComponent
  attr_reader :amount_range, :suffix

  def initialize(amount_range:, suffix:)
    @amount_range = amount_range
    @suffix = suffix
  end

  def amounts
    amount_range.map do |amount|
      helpers.number_to_currency(helpers.number_to_human(amount, format: "%n%u", units: {thousand: "K"}), precision: 0)
    end
  end

  def render?
    amount_range.present?
  end
end
