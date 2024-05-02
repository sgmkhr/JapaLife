class AddPrefectureToRecommendPlacePost < ActiveRecord::Migration[6.1]
  def change
    add_column :recommend_place_posts, :prefecture, :string
  end
end
