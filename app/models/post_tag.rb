class PostTag < ApplicationRecord
  belongs_to :tag
  belongs_to :recommend_place_post
end
