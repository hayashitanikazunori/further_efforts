class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  # フォロー機能の設定
  has_many :following_relationships,foreign_key: "follower_id", class_name: "FollowRelationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships,foreign_key: "following_id", class_name: "FollowRelationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アクティブストレージでuserのavatarと命名
  has_one_attached :avatar

  # バリデーション
  validates :name, presence: true

  def posts
    return Post.where(user_id: self.id)
  end

  def span_total
    total = Post.where(
      kind: self.kind,
      user_id: self.user_id
    )
    return total.sum(:span)
  end

  # kindカラムごとの今週の学習時間の合計
  def week_total
    today = Date.current
    week_total_span = Post.group(:kind)
      .where(created_at: today.in_time_zone.all_week, user_id: self.id)
      .select('kind')
  end

  def week_total2
    today = Date.current
    week_total_span = Post.group(:kind)
      .where(created_at: today.in_time_zone.all_week, user_id: self.id)
      .select('span')
      .sum(:span)
  end

  # すでにいいねをしているかを調べる
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  # フォロー関連のメソッド
  #  すでにフォロー済みであればtrueを返す
  def following?(other_user)
    self.followings.include?(other_user)
  end

  # ユーザーのフォローをできるメソッド
  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end

  # ユーザーのフォローを解除する
  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end
end
