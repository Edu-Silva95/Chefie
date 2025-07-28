class AddCourseIdToRatings < ActiveRecord::Migration[7.2]
  def change
    add_reference :ratings, :course, foreign_key: true
  end
end
