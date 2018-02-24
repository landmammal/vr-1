FactoryBot.define do
  factory :concept do
    description { Faker::Lorem.paragraph }
  end
end
