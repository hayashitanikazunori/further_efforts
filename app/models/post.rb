class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments

  validates :kind, presence: true
  validates :body, presence: true, length: { maximum: 30 }
  validates :span, presence: true, numericality: { only_integer: true, other_than: 0 }

  def user
    return User.find_by(id: self.user_id)
  end

  def span_total
    total = Post.where(
      kind: self.kind,
      user_id: self.user_id
    )
    total.sum(:span)
  end

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
