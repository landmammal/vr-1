FactoryGirl.define do
  factory :feedback do
    instructor nil
    coach nil
    rehearsal nil
    review_status 1
    concept_review 1
    notes "MyText"
    token "MyString"
    video_token "MyString"
    approved false
    video_type "MyString"
  end
end
