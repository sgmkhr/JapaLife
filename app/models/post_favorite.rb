class PostFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :recommend_place_post
  
  validates :user_id, uniqueness: { scope: :recommend_place_post_id }
end
