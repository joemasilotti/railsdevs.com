module OpenStartup
  class RevenueController < ApplicationController
    def index
      @revenue = Revenue.order(occurred_on: :desc)
    end
  end
end
