class PostFavorite < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :recommend_place_post

  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: :recommend_place_post_id }

  after_create do
    create_notification(user_id: recommend_place_post.user_id)
  end

  def notification_message
    "投稿が#{user.nick_name}さんにいいねされました。"
  end

  def notification_path
    recommend_place_post_path(recommend_place_post.id)
  end
end
