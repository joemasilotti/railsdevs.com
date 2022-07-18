class CreateWorkLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :work_locations do |t|
      t.belongs_to :developer, index: {unique: true}, foreign_key: true

      t.boolean :in_person
      t.boolean :remote
      t.boolean :hybrid
      t.boolean :willing_to_relocate

      t.timestamps
    end

    Developer.find_each do |developer|
      developer.create_work_location!
    end
  end
end
