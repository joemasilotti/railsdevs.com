class RenameHiringInvoiceRequestNotificationFormParams < ActiveRecord::Migration[7.0]
  def up
    migrate_notifications(old_param_name: "form", new_param_name: "hiring_invoice_request")
  end

  def down
    migrate_notifications(old_param_name: "hiring_invoice_request", new_param_name: "form")
  end

  def migrate_notifications(old_param_name:, new_param_name:)
    # 2. Rename params key name
    rename_sql = <<-SQL.squish
      UPDATE notifications
      SET params = jsonb_set( params, '{#{new_param_name}}', params->'#{old_param_name}')::jsonb - '#{old_param_name}'
      WHERE params->'#{old_param_name}'->>'_aj_globalid' LIKE '%Businesses::HiringInvoiceRequest%';
    SQL
    execute(rename_sql)

    # 3. Symbolize new key with ActiveRecord
    Notification.where(type: "Admin::Businesses::HiringInvoiceRequestNotification").each do |notification|
      notification.update!(params: notification.params.transform_keys do |key|
        key == new_param_name ? new_param_name.to_sym : key
      end)
    end
  end
end
