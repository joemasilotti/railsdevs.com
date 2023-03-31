class CreateRoleTypes < ActiveRecord::Migration[7.0]
  class Developer < ActiveRecord::Base
  end

  class RoleType < ActiveRecord::Base
  end

  def change
    create_table :role_types do |t|
      t.belongs_to :developer, index: {unique: true}, foreign_key: true

      t.boolean :part_time_contract
      t.boolean :full_time_contract
      t.boolean :full_time_employment

      t.timestamps
    end

    Developer.find_each do |developer|
      RoleType.create!(developer_id: developer.id)
    end
  end
end
