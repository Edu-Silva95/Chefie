class ReplyLike < ApplicationRecord
  belongs_to :reply
  belongs_to :user

  validates :user_id, uniqueness: { scope: :reply_id }
end
