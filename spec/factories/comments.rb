FactoryBot.define do
  factory :comment do
    review { "review" }
    user { nil }
    post { nil }
  end
end
