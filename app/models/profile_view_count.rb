class ProfileViewCount < ApplicationRecord
  belongs_to :viewer, class_name: 'User'
  belongs_to :viewed, class_name: 'User'
end
