FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '1234abcd' }
    name { 'test_user' }
  end
end