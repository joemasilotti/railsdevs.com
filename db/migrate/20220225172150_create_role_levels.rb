class CreateRoleLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :role_levels do |t|
      t.belongs_to :developer, index: {unique: true}, foreign_key: true

      t.boolean :junior
      t.boolean :mid
      t.boolean :senior
      t.boolean :principal
      t.boolean :c_level

      t.timestamps
    end
  end
end
