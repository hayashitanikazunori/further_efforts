class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'FollowRelationship', dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'FollowRelationship', dependent: :destroy
  has_many :followers, through: :follower_relationships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable
        #  omniauth_providers: [:facebook, :twitter, :google_oauth2]

  validates :name, presence: true, length: { in: 1..20 }

  has_one_attached :avatar

  def posts
    Post.where(user_id: id).order('id DESC')
  end

  def self.week_ranking
    User.find(
      Post.group(:user_id)
      .where(created_at: Date.current.in_time_zone.all_week)
      .order('sum(learned_time) desc')
      .limit(10)
      .pluck(:user_id)
    )
  end

  def learning_profile
    total_time = Post.group(:learning_language).where(user_id: id).sum(:learned_time).to_a
    week_total_time = Post.group(:learning_language)
                          .where(created_at: Date.current.in_time_zone.all_week, user_id: id)
                          .sum(:learned_time)
    post_counts = Post.group(:learning_language).where(user_id: id).count.values
    total_time.map.with_index { |total_time, i| total_time.push(week_total_time.fetch(total_time[0], 0), post_counts[i]) }
  end

  def week_learn_time
    week_learn_time = Post.where(user_id: id, created_at: Date.current.in_time_zone.all_week)
    week_learn_time.sum(:learned_time)
  end

  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def follow(other_user)
    following_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def self.guest
    find_or_create_by!(name: 'guest', email: 'guset@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        name:  auth.info.name,
        password: Devise.friendly_token[0, 20],
      )
    end

    user
  end
end
