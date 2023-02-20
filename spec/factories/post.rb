FactoryBot.define do
  factory :post do
    architecture { Faker::Lorem.characters(number:10) }
    architect { Faker::Name.name }
    body { Faker::Lorem.characters(number:20) }
    address { Faker::Address.full_address }
    
    trait :with_image do
      after(:build) do |post|
        post.post_image.attach(io: File.open('spec/factories/test_image.jpg'), filename: 'test_image.jpg', content_type: 'image/jpg')
      end
    end
    
    association :user
  end
end