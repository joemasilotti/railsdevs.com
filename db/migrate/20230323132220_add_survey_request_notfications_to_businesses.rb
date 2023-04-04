class AddSurveyRequestNotficationsToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :survey_request_notifications, :boolean, default: true
  end
end
