class AddDetailsToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :ingredients, :text
    add_column :recipes, :instructions, :text
    add_column :recipes, :prep_time, :string
  end
end
