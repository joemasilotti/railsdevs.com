class AddExpectedCompensationFieldsToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_monetize :developers, :expected_salary, amount: {null: true, default: nil}
    add_monetize :developers, :expected_hourly_rate, amount: {null: true, default: nil}
  end
end
