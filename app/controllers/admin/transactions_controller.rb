module Admin
  class TransactionsController < ApplicationController
    def index
      @transactions = OpenStartup::Transaction.order(occurred_on: :desc)
    end

    def new
      @transaction = OpenStartup::Transaction.new
    end

    def edit
      @transaction = OpenStartup::Transaction.find(params[:id])
    end

    def create
      @transaction = OpenStartup::Transaction.new(transaction_params)
      if @transaction.save
        redirect_to admin_transactions_path, notice: t(".created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @transaction = OpenStartup::Transaction.find(params[:id])
      if @transaction.update(transaction_params)
        redirect_to admin_transactions_path, notice: t(".updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      OpenStartup::Transaction.find(params[:id]).destroy
      redirect_to admin_transactions_path, notice: t(".destroyed")
    end

    private

    def transaction_params
      params.require(:transaction).permit(
        :occurred_on,
        :transaction_type,
        :description,
        :url,
        :amount
      )
    end
  end
end
