class AddExpectedCompensationFieldsToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :expected_salary, :integer
    add_column :developers, :expected_hourly_rate, :integer
  end
end
