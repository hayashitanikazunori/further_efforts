class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments

  # バリデーション
  validates :kind, presence: true
  validates :body, presence: true, length: { maximum: 30 }
  validates :span, presence: true

  # userモデルの関連付け
  def user
    return User.find_by(id: self.user_id)
  end

  # kindカラム毎の合計時間算出
  def span_total
    total = Post.where(
      kind: self.kind,
      user_id: self.user_id
    )
    return total.sum(:span)
  end

  # form_with selectの配列
  enum kind: {
    JavaScript: "JavaScript",
    Ruby: "Ruby",
    Python: "Python",
    Go: "Go",
    Swift: "Swift",
    'C++': "C++",
    'C#': "C#",
    PHP: "PHP",
    Scala: "Scala",
    Kotlin: "Kotlin",
    Java: "Java",
  }, _prefix: true

end
