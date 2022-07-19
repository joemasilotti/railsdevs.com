class AddStackOverflowToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :stack_overflow, :string
  end
end
