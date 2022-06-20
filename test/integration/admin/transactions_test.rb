require "test_helper"

class TransactionsTest < ActionDispatch::IntegrationTest
  test "must be signed in" do
    get admin_transactions_path
    assert_redirected_to new_user_session_path
  end

  test "must be an admin" do
    sign_in users(:empty)
    get admin_transactions_path
    assert_redirected_to root_path
  end

  test "lists all transactions" do
    sign_in users(:admin)
    get admin_transactions_path
    assert_select "td", text: "Donation"
    assert_select "td", text: "Expense"
  end

  test "builds a new transaction" do
    sign_in users(:admin)
    get new_admin_transaction_path
    assert_select "form[action='#{admin_transactions_path}']"
  end

  test "creates a transaction" do
    sign_in users(:admin)

    assert_difference "OpenStartup::Transaction.count", 1 do
      post admin_transactions_path, params: transaction_params
    end

    assert_redirected_to admin_transactions_path
  end

  test "edits a transaction" do
    transaction = open_startup_transactions(:expense)
    sign_in users(:admin)

    get edit_admin_transaction_url(transaction)
    assert_select "form[action='#{admin_transaction_path(transaction)}']"
  end

  test "updates a transaction" do
    transaction = open_startup_transactions(:expense)
    sign_in users(:admin)

    patch admin_transaction_url(transaction, params: transaction_params(description: "New"))

    assert_redirected_to admin_transactions_path
    assert_equal transaction.reload.description, "New"
  end

  test "destroys a transaction" do
    sign_in users(:admin)

    assert_difference "OpenStartup::Transaction.count", -1 do
      delete admin_transaction_path(open_startup_transactions(:expense))
    end

    assert_redirected_to admin_transactions_url
  end

  def transaction_params(description: "Description")
    {
      transaction: {
        occurred_on: Date.today,
        transaction_type: :expense,
        description:,
        amount: 42.00
      }
    }
  end
end
