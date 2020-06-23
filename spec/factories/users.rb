FactoryBot.define do
  factory :user do
    avatar {"img_test.png"}
    name {"tester"}
    email {"tester@example.com"}
    password {"test01"}
    password_confirmation {"test01"}
  end
end
