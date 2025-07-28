class AddCompositeIndexToLikes < ActiveRecord::Migration[7.2]
  def change
    # Check if index exists before adding it
    unless index_exists?(:likes, [:user_id, :likeable_id, :likeable_type])
      add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true
    end
  end
end
