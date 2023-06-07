class AddFullNameToHiringAgreementsSignatures < ActiveRecord::Migration[7.0]
  def change
    add_column :hiring_agreements_signatures, :full_name, :string
    add_column :hiring_agreements_signatures, :ip_address, :string
  end
end
