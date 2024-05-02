class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :recommend_place_post
  has_many :comment_favorites, dependent: :destroy
  
  validates :content, presence: true, length: { maximum:50 }
  
  def favorited_by?(user)
    comment_favorites.exists?(user_id: user.id)
  end
end
