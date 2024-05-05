class CommentFavorite < ApplicationRecord
  include Notifiable
  
  belongs_to :user
  belongs_to :post_comment
  
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :post_comment_id }
  
  after_create do
    create_notification(user_id: post_comment.user_id)
  end
  
  def notification_message
    "投稿したコメントが#{user.nick_name}さんにいいねされました。"
  end
  
  def notification_path
    recommend_place_post_path(post_comment.recommend_place_post_id)
  end
end
