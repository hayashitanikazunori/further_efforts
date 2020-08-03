class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  has_many :following_relationships,foreign_key: "follower_id", class_name: "FollowRelationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships,foreign_key: "following_id", class_name: "FollowRelationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable

  validates :name, presence: true, length: { in: 1..20 }

  has_one_attached :avatar
  
  def posts
    return Post.where(user_id: self.id).order('id DESC')
  end

  def self.week_ranking
    User.find( 
      Post.group(:user_id)
      .where(created_at: Date.current.in_time_zone.all_week)
      .order("sum(learned_time) desc")
      .limit(10)
      .pluck(:user_id)
    )
  end

  def total_and_counts
    total_learned_time = Post.group(:learning_language).where(user_id: self.id).sum(:learned_time).to_a
    week_total_learned_time = Post.group(:learning_language).where(created_at: Date.current.in_time_zone.all_week, user_id: self.id).sum(:learned_time)
    total_counts = Post.group(:learning_language).where(user_id: self.id).count.values
    total_learned_time.map.with_index {|total_learned_time, i| total_learned_time.push(week_total_learned_time.fetch(total_learned_time[0], 0), total_counts[i])}
  end

  def week_all_total_learned_time
    today = Date.current
    week_all_total_learned_time = Post.where(user_id: self.id, created_at: today.in_time_zone.all_week)
    week_all_total_learned_time.sum(:learned_time)
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end

  def self.guest
    find_or_create_by!(name: 'guest', email: 'guset@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end
end
