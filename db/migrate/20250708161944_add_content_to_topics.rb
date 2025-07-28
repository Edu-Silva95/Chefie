class AddContentToTopics < ActiveRecord::Migration[7.2]
  def change
    add_column :topics, :content, :text
  end
end
