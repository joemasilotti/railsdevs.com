class RenameHiredFormsToDevelopersCelebrationPackageRequests < ActiveRecord::Migration[7.0]
  def change
    rename_table :hired_forms, :developers_celebration_package_requests
  end
end
