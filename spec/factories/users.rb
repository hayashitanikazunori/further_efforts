FactoryBot.define do
  factory :user do
    name { 'test01' }
    email { 'test01@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }
  end
end
