FactoryBot.define do
  factory :post do
    architecture { Faker::Lorem.characters(number:10) }
    architect { Faker::Name.name }
    body { Faker::Lorem.characters(number:20) }
    address { Faker::Address.full_address }
  end
end