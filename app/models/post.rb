class Post < ApplicationRecord
  belongs_to :user

  # バリデーション
  validates :kind, presence: true
  validates :body, presence: true, length: { maximum: 30 }
  validates :span, presence: true

  def user
    return User.find_by(id: self.user_id)
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
