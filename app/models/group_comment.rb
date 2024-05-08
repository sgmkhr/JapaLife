class GroupComment < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 200 }

  scope :latest, -> { order(created_at: :desc) }
end
