module StripeHelper
  class BalanceTransaction
    attr_reader :id, :amount, :created, :description, :fee, :type

    def initialize(amount:, created:, description:, fee:, type:)
      @id = "ch_#{rand(1...10000)}"
      @amount = amount
      @created = created
      @description = description
      @fee = fee
      @type = type
    end
  end
end
