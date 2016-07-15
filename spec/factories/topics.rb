FactoryGirl.define do
  factory :topic do
    course_id {"#{Faker::Number.between(1,20)}"}
    instructor_id {"#{Faker::Number.between(1,20)}"}
    status {"#{Faker::Number.between(0,2)}"}
    title {"#{Faker::Space.planet}"}
    description {"#{Faker::Space.agency}"}
    tags {"#{Faker::Space.galaxy}"}
  end
end
