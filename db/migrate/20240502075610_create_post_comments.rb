class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :recommend_place_post_id
      t.timestamps
    end
  end
end
