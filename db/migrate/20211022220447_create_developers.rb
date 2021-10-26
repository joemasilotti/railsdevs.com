class CreateDevelopers < ActiveRecord::Migration[7.0]
  def change
    create_table :developers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.date :available_on, null: false
      t.string :hero, null: false
      t.text :bio, null: false
      t.string :website
      t.string :github
      t.string :twitter

      t.timestamps
    end
  end
end
