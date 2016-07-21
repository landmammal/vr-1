FactoryGirl.define do
  factory :lesson do
    topic_id nil
    lesson_title { Faker::Lorem.word }
    explanation { Faker::Lorem.sentence(1) }
    tags { Faker::Lorem.word(3) }
  end
end
