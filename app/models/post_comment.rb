class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :recommend_place_post
  
  validates :content, presence: true, length: { maximum:50 }
end
