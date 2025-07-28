class CreateReplyLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :reply_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reply, null: false, foreign_key: true

      t.timestamps
    end

    add_index :reply_likes, [:user_id, :reply_id], unique: true
  end
end
