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
         :recoverable, :rememberable, :validatable, :confirmable,
         # 外部APIのomniauthableモジュールを追加
         :omniauthable, omniauth_providers: [:facebook, :twitter, :google_oauth2]

  # アクティブストレージでuserのavatarと命名
  has_one_attached :avatar

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

  # user/showで学習言語ごとの情報を返す
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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(_, session)
    super.tap do |user|
      if (data = session['devise.omniauth_data'])
        user.email = data['email'] if user.email.blank?
        user.provider = data['provider'] if data['provider'] && user.provider.blank?
        user.uid = data['uid'] if data['uid'] && user.uid.blank?
        user.skip_confirmation!
      end
    end
  end

  # ゲストユーザー
  def self.guest
    find_or_create_by!(name: 'guest', email: 'guset@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end
end
