class AddTopicToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :topic, foreign_key: true, null: true
  end
end
