class CreateUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :updates do |t|
      t.string :name
      t.string :description
      t.string :citation
      t.integer :score
      t.integer :user_id

      t.timestamps
    end
  end
end
