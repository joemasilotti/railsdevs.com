class Admin::Forms::CurrencyInputComponent < Admin::Forms::BaseComponent
  attr_reader :currency, :currency_symbol

  def initialize(form, field, classes:, currency: "USD", currency_symbol: "$")
    super(form, field, classes:)
    @currency = currency
    @currency_symbol = currency_symbol
  end
end
