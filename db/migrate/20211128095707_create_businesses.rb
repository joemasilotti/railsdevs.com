class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.belongs_to :user
      t.string :name, null: false
      t.string :company, null: false

      t.timestamps
    end
  end
end
