class FollowRelationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  # バリデーション
  validates :follower_id, presence: true
  validates :following_id, presence: true
end