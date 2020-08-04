FactoryBot.define do
  factory :comment do
    body { 'body' }
    user { nil }
    post { nil }
  end
end
