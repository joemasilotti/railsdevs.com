class AddGitlabToDeveloper < ActiveRecord::Migration[7.0]
  def change
    change_table :developers do |t|
      t.string :gitlab
    end
  end
end
