class AddCompanyBooleanToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :company, :boolean, default: false
  end
end
