class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :message, presence: true, length: { maximum:140 }
  
  after_create do
    chat.room.user_rooms.each do |user_room|
      if user_room.user_id != current_user.id
        create_notification(user_id: user_room.user_id)
      end
    end
  end
end
