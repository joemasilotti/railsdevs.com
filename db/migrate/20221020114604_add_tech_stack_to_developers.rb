class AddTechStackToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :tech_stack, :string
  end
end
