FactoryGirl.define do
  factory :lesson do
    topic_id nil
    lesson_title {"#{Faker::Lorem.word}"}
    explanation {"#{Faker::Lorem.sentence(1)}"}
    prompt "123"
    role_model "dsfsdf"
    performance "dfsdfs"
    explanation_script "customer service tutorial"
    prompt_script "sdfsdf"
    model_script "sdfsdf"
  end


end
