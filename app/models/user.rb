class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アクティブストレージでuserのavatarと命名
  has_one_attached :avatar

  # バリデーション
  validates :name, presence: true

  def posts
    return Post.where(user_id: self.id)
  end
end
