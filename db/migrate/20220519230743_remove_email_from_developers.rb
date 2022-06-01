class RemoveEmailFromDevelopers < ActiveRecord::Migration[7.0]
  def change
    remove_column :developers, :email, :string
  end
end
