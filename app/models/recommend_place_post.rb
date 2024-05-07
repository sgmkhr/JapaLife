class RecommendPlacePost < ApplicationRecord
  include Notifiable

  has_one_attached :post_image

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_view_counts, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :notifications, as: :notifiable, dependent: :destroy

  has_many :post_saves, dependent: :destroy

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }

  validates :name, presence: true
  validates :caption, length: { maximum:20 }
  validates :introduction, length: { maximum:2000 }
  validates :prefecture, presence: true

  enum prefecture: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47,その他:48,指定しない:49
  }

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no-post-image.png')
      post_image.attach(io: File.open(file_path), filename: 'default-post-image.png', content_type: 'image/png')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    post_favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method, prefecture_number, subject)
    if method == 'perfect'
      if subject == 'name'
        records = RecommendPlacePost.where(name: content)
      elsif subject == 'caption'
        records = RecommendPlacePost.where(caption: content)
      else
        records = RecommendPlacePost.where(introduction: content)
      end
      unless prefecture_number == 49
        records.where(prefecture: prefecture_number)
      end
      records
    else
      if subject == 'name'
        records = RecommendPlacePost.where('name LIKE?', '%' + content + '%')
      elsif subject == 'caption'
        records = RecommendPlacePost.where('caption LIKE?', '%' + content + '%')
      else
        records = RecommendPlacePost.where('introduction LIKE?', '%' + content + '%')
      end
      unless prefecture_number == 49
        records.where(prefecture: prefecture_number)
      end
      records
    end
  end

  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
      self.tags << post_tag
    end
  end

  after_create do
    records = user.followers.map do |follower|
      notifications.new(user_id: follower.id)
    end
    Notification.import records
  end

  def notification_message
    "フォローしている#{user.nick_name}さんが新規投稿しました。"
  end

  def notification_path
    recommend_place_post_path(self)
  end

  def post_saved_by?(user)
    post_saves.exists?(user_id: user.id)
  end
end
