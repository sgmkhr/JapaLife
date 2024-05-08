class Category < ApplicationRecord
  has_many :group_categories, dependent: :destroy
  has_many :groups, through: :group_categories

  validates :name, presence: true, length: { maximum: 20 }
end
