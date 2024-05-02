class CreateRecommendPlacePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :recommend_place_posts do |t|
      t.integer :user_id
      t.string :name
      t.text :caption
      t.text :introduction

      t.timestamps
    end
  end
end
