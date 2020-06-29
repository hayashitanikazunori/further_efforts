class Post < ApplicationRecord
  # バリデーション
  validates :kind, presence: true
  validates :body, presence: true, length: { maximum: 30 }
  validates :span, presence: true

  # form_with selectの配列
  enum kind: {
    JavaScript: 0,
    Ruby: 1,
    Python: 2,
    Go: 3,
    Swift: 4,
    'C++': 5,
    'C#': 6,
    PHP: 7,
    Scala: 8,
    Kotlin: 9,
    Java: 10,
  }, _prefix: true

end
