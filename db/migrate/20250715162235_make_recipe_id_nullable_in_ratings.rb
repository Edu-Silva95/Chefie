class MakeRecipeIdNullableInRatings < ActiveRecord::Migration[7.2]
  def change
    change_column_null :ratings, :recipe_id, true
  end
end
