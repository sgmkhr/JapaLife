class Group < ApplicationRecord
  has_many :group_categories, dependent: :destroy
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users

  validates :name, presence: true, length: { maximum:20 }
  validates :introduction, presence: true, length: { maximum:100 }

  has_one_attached :group_image

  def is_owned_by?(user)
    owner.id == user.id
  end

  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no-group-img.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-group-image.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def includes_user?(user)
    group_users.exists?(user_id: user.id)
  end
end
