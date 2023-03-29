module Hired
  class Form < ActiveRecord::Base
    self.table_name = "hired_forms"
  end
end

class RenameHiredFormsToDevelopersCelebrationPackageRequests < ActiveRecord::Migration[7.0]
  def up
    rename_table :hired_forms, :developers_celebration_package_requests

    Notification.where(type: "Admin::NewHiredFormNotification")
      .update_all(type: "Admin::Developers::NewCelebrationPackageRequestNotification")

    migrate_notifications(
      notification_type: "Admin::Developers::NewCelebrationPackageRequestNotification",
      old_model_name: "Hired::Form",
      old_param_key: "form",
      new_model_name: "Developers::CelebrationPackageRequest",
      new_param_key: "celebration_package_request"
    )
  end

  def down
    rename_table :developers_celebration_package_requests, :hired_forms

    Notification.where(type: "Admin::Developers::NewCelebrationPackageRequestNotification")
      .update_all(type: "Admin::NewHiredFormNotification")

    migrate_notifications(
      notification_type: "Admin::NewHiredFormNotification",
      old_model_name: "Developers::CelebrationPackageRequest",
      old_param_key: "celebration_package_request",
      new_model_name: "Hired::Form",
      new_param_key: "form"
    )
  end

  def migrate_notifications(notification_type:, old_model_name:, old_param_key:, new_model_name:, new_param_key:)
    gid_replace_sql = "REPLACE(params->'#{old_param_key}'->>'_aj_globalid', '#{old_model_name}', '#{new_model_name}')"

    # Only update records that actually contain the old Global ID
    where_clause = "params->'#{old_param_key}'->>'_aj_globalid' LIKE '%#{old_model_name}%'"

    # 1. Update class
    update_sql = <<-SQL.squish
      UPDATE notifications
      SET params = jsonb_set(params, '{#{old_param_key},_aj_globalid}', to_jsonb(#{gid_replace_sql}))
      WHERE #{where_clause}
    SQL
    execute(update_sql)

    # 2. Change params key name
    rename_sql = <<-SQL.squish
      UPDATE notifications
      SET params = jsonb_set( params, '{#{new_param_key}}', params->'#{old_param_key}')::jsonb - '#{old_param_key}'
      WHERE params->'#{old_param_key}'->>'_aj_globalid' LIKE '%#{new_model_name}%';
    SQL
    execute(rename_sql)

    # 3. Symbolize new key with ActiveRecord
    Notification.where(type: notification_type).each do |notification|
      notification.update!(params: notification.params.transform_keys do |key|
        key == new_param_key ? new_param_key.to_sym : key
      end)
    end
  end
end
