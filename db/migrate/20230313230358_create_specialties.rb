class CreateSpecialties < ActiveRecord::Migration[7.0]
  def change
    create_table :specialties do |t|
      t.string :name, null: false, index: {unique: true}
      t.integer :developers_count, null: false, default: 0

      t.timestamps
    end

    create_table :specialty_tags do |t|
      t.belongs_to :specialty, null: false, foreign_key: true
      t.belongs_to :developer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
