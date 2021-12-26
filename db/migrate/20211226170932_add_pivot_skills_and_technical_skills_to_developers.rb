class AddPivotSkillsAndTechnicalSkillsToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :pivot_skills, :text, null: false
    add_column :developers, :technical_skills, :text, null: false
  end
end
