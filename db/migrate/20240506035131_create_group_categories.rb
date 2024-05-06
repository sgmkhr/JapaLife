class CreateGroupCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :group_categories do |t|
      t.integer :group_id, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
