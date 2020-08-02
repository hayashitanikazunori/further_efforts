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
         :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2]

  validates :name, presence: true, length: { in: 1..20 }

  has_one_attached :avatar
  
  def posts
    return Post.where(user_id: self.id).order('id DESC')
  end

  def span_total
    total = Post.where(
      kind: self.kind,
      user_id: self.user_id
    )
    return total.sum(:span)
  end

  def self.rank_user
    User.find( 
    Post.group(:user_id) # user_idでグループ化
    .where(created_at: Date.current.in_time_zone.all_week) # 今週の投稿のみで絞り込み
    .order("sum(span) desc") # spanカラムを合計してそれを降順に並び替える
    .limit(10) # 10番目まで取得
    .pluck(:user_id) # 最後にuser_idを返す
    )
  end

  def total_and_counts
    today = Date.current
    
    total_spans = Post.group(:kind).where(user_id: self.id).sum(:span).to_a
    week_total_spans = Post.group(:kind).where(created_at: today.in_time_zone.all_week, user_id: self.id).sum(:span)
    total_counts = Post.group(:kind).where(user_id: self.id).count.values
    total_spans.map.with_index {|total_span, i| total_span.push(week_total_spans.fetch(total_span[0], 0), total_counts[i])}
  end

  def week_all_total_spans
    today = Date.current
    week_all_total_spans = Post.where(user_id: self.id, created_at: today.in_time_zone.all_week)
    return week_all_total_spans.sum(:span)
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

  def self.guest
    find_or_create_by!(name: 'guest', email: 'guset@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = "未設定"
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
