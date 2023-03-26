class RenameHiredFormsToDevelopersCelebrationPackageRequests < ActiveRecord::Migration[7.0]
  def up
    rename_table :hired_forms, :developers_celebration_package_requests

    Notification.where(type: "Admin::NewHiredFormNotification")
      .update_all(type: "Admin::Developers::NewCelebrationPackageRequestNotification")

    migrate_notifications("Hired::Form", "Developers::CelebrationPackageRequest")
  end

  def down
    rename_table :developers_celebration_package_requests, :hired_forms

    Notification.where(type: "Admin::Developers::NewCelebrationPackageRequestNotification")
      .update_all(type: "Admin::NewHiredFormNotification")

    migrate_notifications("Developers::CelebrationPackageRequest", "Hired::Form")
  end

  def migrate_notifications(old_model_name, new_model_name)
    gid_replace_sql = "REPLACE(params->'form'->>'_aj_globalid', '#{old_model_name}', '#{new_model_name}')"

    # Only update records that actually contain the old Global ID
    where_clause = "params->'form'->>'_aj_globalid' LIKE '%#{old_model_name}%'"

    update_sql = <<-SQL.squish
      UPDATE notifications
      SET params = jsonb_set(params, '{form,_aj_globalid}', to_jsonb(#{gid_replace_sql}))
      WHERE #{where_clause}
    SQL

    execute(update_sql)
  end
end
