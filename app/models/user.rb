class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  
  has_many :recommend_place_posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :comment_favorites, dependent: :destroy

  validates :name, presence: true
  validates :nick_name, presence: true, uniqueness: true
  validates :introduction, length: { maximum:50 }
  validates :role, presence: true

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'guestuser'
      user.nick_name = 'guest_user'
      user.role = 'begginer'
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def get_role
    if self.role = 'beginner'
      '初心者'
    elsif self.role = 'intermediate'
      '中級者'
    else 
      'ベテラン'
    end
  end
end
