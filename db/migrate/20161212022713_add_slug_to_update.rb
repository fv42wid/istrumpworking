class AddSlugToUpdate < ActiveRecord::Migration[5.0]
  def change
    add_column :updates, :slug, :string
    add_index :updates, :slug, unique: true
  end
end
