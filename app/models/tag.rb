class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :recommend_place_posts, through: :post_tags
  
  validates :name, length: { maximum:10 }
  
  scope :merge_posts, -> (tags){ }
  
  def self.search_posts_for(content)
    tags = Tag.where(name: content)
    return tags.inject(init = []) {|result, tag| result + tag.recommend_place_posts}
  end
end
