class User < ApplicationRecord
  has_one_attached :avatar

  has_many :ratings, dependent: :destroy
  has_many :communities
  has_many :topics
  has_many :courses, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :recipes
  has_many :favorites, dependent: :destroy
  has_many :favorited_recipes, through: :favorites, source: :recipe
  has_many :likes, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :reply_likes, dependent: :destroy
  has_many :liked_replies, through: :reply_likes, source: :reply

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { in: 3..20 }
end
