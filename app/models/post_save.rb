class PostSave < ApplicationRecord
  belongs_to :user
  belongs_to :recommend_place_post

end
