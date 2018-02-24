FactoryBot.define do
  factory :explanation do
    script { Faker::Lorem.sentence(3) }
    token { Faker::Space.agency }
    video_token { Faker::Space.agency }
  end
end
