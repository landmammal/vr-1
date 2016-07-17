FactoryGirl.define do
  factory :topic do
    title { Faker::Space.planet }
    description { Faker::Space.agency }
    tags { Faker::Space.galaxy }
    course_id { Faker::Number.between(1,20) }
    instructor_id
  end
end
