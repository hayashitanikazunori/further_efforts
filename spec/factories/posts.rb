FactoryBot.define do
  factory :post do
    kind {'JavaScript'}
    body {'testを記述'}
    span {'100'}
    user
  end
end
