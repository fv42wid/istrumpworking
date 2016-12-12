class AddSlugToIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :slug, :string
    add_index :issues, :slug, unique: true
  end
end
