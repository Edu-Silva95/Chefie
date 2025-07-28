class Recipe < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :ratings, as: :ratable

  def average_rating
    ratings.average(:value)&.round(2) || 0
  end

  def recipe_params
    params.require(:recipe).permit(:title, :category, :prep_time, :ingredients, :instructions, :description, :image)
  end
end
