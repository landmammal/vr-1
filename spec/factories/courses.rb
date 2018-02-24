FactoryBot.define do
  factory :course do
    title { Faker::Space.planet }
    description { Faker::Space.agency }
    tags  { Faker::Space.company }
    instructor_id nil
  end
end
