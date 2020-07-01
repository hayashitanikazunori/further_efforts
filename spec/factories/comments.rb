FactoryBot.define do
  factory :comment do
    review { "MyString" }
    user { nil }
    post { nil }
  end
end
