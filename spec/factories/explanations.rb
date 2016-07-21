FactoryGirl.define do
  factory :explanation do
    script { Faker::Lorem.pragraph }
    token { Faker::Space.agency }
    video_token { Faker::Space.agency }
  end
end
