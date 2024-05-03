class CreatePostViewCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :post_view_counts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recommend_place_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
