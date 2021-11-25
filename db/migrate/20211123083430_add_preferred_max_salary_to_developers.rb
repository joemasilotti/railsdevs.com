class AddPreferredMaxSalaryToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :preferred_max_salary, :integer
  end
end
