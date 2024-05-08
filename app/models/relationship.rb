class Relationship < ApplicationRecord
  include Notifiable

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  has_one :notification, as: :notifiable, dependent: :destroy

  after_create do
    create_notification(user_id: followed_id)
  end

  def notification_message
    "#{follower.nick_name}さんにフォローされました。"
  end

  def notification_path
    user_path(follower_id)
  end
end
