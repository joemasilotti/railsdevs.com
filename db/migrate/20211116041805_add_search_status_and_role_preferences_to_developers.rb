class AddSearchStatusAndRolePreferencesToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :search_status, :integer

    add_column :developers, :part_time_contract, :boolean
    add_column :developers, :full_time_contract, :boolean
    add_column :developers, :full_time_employment, :boolean
  end
end
