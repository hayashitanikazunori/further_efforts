class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments

  validates :learning_language, presence: true
  validates :memo, presence: true, length: { maximum: 30 }
  validates :learned_time, presence: true, numericality: { only_integer: true, other_than: 0 }

  def user
    User.find_by(id: user_id)
  end

  def learned_time_total
    total = Post.where(
      learning_language: learning_language,
      user_id: user_id
    )
    total.sum(:learned_time)
  end

  enum learning_language: {
    JavaScript: 'JavaScript',
    Ruby: 'Ruby',
    Python: 'Python',
    Go: 'Go',
    Swift: 'Swift',
    'C++': 'C++',
    'C#': 'C#',
    PHP: 'PHP',
    Scala: 'Scala',
    Kotlin: 'Kotlin',
    Java: 'Java'
  }, _prefix: true
end
