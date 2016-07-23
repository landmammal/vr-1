FactoryGirl.define do
  factory :lesson do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3) }
    tags { Faker::Lorem.word }
  end
end
