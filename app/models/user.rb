class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アクティブストレージでuserのavatarと命名
  has_one_attached :avatar

  # バリデーション
  validates :name, presence: true

  def posts
    return Post.where(user_id: self.id)
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
