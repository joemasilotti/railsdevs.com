class AddLinkedinToDeveloper < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :linkedin, :string
  end
end
