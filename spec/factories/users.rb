FactoryBot.define do
  factory :user do
    avatar {"img_test.png"}
    name {"tester"}
    email {"tester@example.com"}
    password {"tester01"}
    password_confirmation {"tester01"}
  end
end
