FactoryBot.define do
  factory :post do
    learning_language { 'JavaScript' }
    memo { 'testを記述' }
    learned_time { '100' }
    user
  end
end
