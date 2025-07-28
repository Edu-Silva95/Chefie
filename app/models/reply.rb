class Reply < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  has_many :reply_likes, dependent: :destroy
  has_many :liked_users, through: :reply_likes, source: :user

  validates :content, presence: true
end
