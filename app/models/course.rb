class Course < ApplicationRecord
  belongs_to :user

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :ratings, as: :ratable

  validates :name, presence: true
  validates :youtube_url, presence: true, format: URI::regexp(%w[http https])
  validates :description, presence: true

  def likes_count
    likes.count
  end

  def average_rating
    return 0 if ratings.empty?

    ratings.average(:value).to_f.round(2)
  end
end
