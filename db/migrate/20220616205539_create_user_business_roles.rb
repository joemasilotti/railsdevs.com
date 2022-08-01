class CreateUserBusinessRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_business_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true

      t.integer :role_type, default: 0
      t.timestamps
    end
    Business.find_each do |b|
      UserBusinessRole.create(user: b.user, business: b, role_type: :admin)
    end
  end
end
