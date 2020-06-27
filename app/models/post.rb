class Post < ApplicationRecord
  # バリデーション
  validates :kind, presence: true
  validates :body, presence: true
  validates :span, presence: true
end
