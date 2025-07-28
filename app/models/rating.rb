class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :ratable, polymorphic: true

  validates :value, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: [:ratable_type, :ratable_id], message: "has already rated this item" }
end
