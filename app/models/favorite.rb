class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe, optional: true
  belongs_to :course, optional: true


  validates :user_id, uniqueness: { scope: :recipe_id, message: "has already favorited this recipe" }
end
