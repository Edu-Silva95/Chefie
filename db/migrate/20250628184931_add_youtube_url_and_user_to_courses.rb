class AddYoutubeUrlAndUserToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :youtube_url, :string
    add_reference :courses, :user, null: false, foreign_key: true
  end
end
