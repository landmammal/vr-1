FactoryGirl.define do
  factory :topic do
    title { Faker::Space.planet }
    description { Faker::Space.agency }
    tags { Faker::Space.galaxy }
  end
end
