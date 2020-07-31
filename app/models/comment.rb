class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :review, presence: true, length: { maximum: 50 }
end
