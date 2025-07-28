class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.string :…

      t.timestamps
    end
  end
end
