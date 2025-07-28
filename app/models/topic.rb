class Topic < ApplicationRecord
  belongs_to :community
  belongs_to :user
  has_many   :replies, dependent: :destroy

  validates :title, presence: true
end
