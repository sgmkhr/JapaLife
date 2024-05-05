class CommentFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :post_comment
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :post_comment_id }
  
  after_create do
    create_notification(user_id: post_comment.user_id)
  end
end
