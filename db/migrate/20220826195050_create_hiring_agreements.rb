class CreateHiringAgreements < ActiveRecord::Migration[7.0]
  def change
    create_table :hiring_agreements_terms do |t|
      t.text :body, null: false
      t.boolean :active, null: false, default: false

      t.timestamps
    end

    create_table :hiring_agreements_signatures do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :hiring_agreements_term, null: false, foreign_key: true

      t.timestamps
    end
  end
end
