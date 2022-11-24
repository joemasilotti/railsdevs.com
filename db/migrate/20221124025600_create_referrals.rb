class CreateReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :referrals do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :code, null: false

      t.timestamps
    end
  end
end
