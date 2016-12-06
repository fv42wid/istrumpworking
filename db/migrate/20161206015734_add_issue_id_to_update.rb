class AddIssueIdToUpdate < ActiveRecord::Migration[5.0]
  def change
    add_column :updates, :issue_id, :integer
  end
end
