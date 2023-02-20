FactoryBot.define do
  factory :user do
    email { 'sample@sample.com' }
    password { '1234abcd' }
    name { 'test_user' }
  end
end