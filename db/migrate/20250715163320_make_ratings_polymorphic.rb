class MakeRatingsPolymorphic < ActiveRecord::Migration[7.2]
  def up
    #  Add polymorphic columns nullable first
    add_reference :ratings, :ratable, polymorphic: true, null: true

    # Backfill existing data from recipe_id or course_id into ratable_type and ratable_id
    execute <<-SQL.squish
      UPDATE ratings
      SET ratable_type = 'Recipe', ratable_id = recipe_id
      WHERE recipe_id IS NOT NULL
    SQL

    execute <<-SQL.squish
      UPDATE ratings
      SET ratable_type = 'Course', ratable_id = course_id
      WHERE course_id IS NOT NULL
    SQL

    # Remove old foreign keys and columns
    remove_reference :ratings, :recipe, foreign_key: true
    remove_reference :ratings, :course, foreign_key: true

    # Make ratable references NOT NULL now that data is filled
    change_column_null :ratings, :ratable_type, false
    change_column_null :ratings, :ratable_id, false
  end

  def down
    add_reference :ratings, :recipe, foreign_key: true
    add_reference :ratings, :course, foreign_key: true

    execute <<-SQL.squish
      UPDATE ratings
      SET recipe_id = ratable_id
      WHERE ratable_type = 'Recipe'
    SQL

    execute <<-SQL.squish
      UPDATE ratings
      SET course_id = ratable_id
      WHERE ratable_type = 'Course'
    SQL

    remove_reference :ratings, :ratable, polymorphic: true, null: false
  end
end
