class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  # ひとりのユーザーはひとつの投稿にひとつしかいいねができないバリデーション
  validates_uniqueness_of :post_id, scope: :user_id
end
