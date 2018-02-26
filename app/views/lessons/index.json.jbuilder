json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :course_id, :topic_id, :lesson_title, :explanation, :prompt, :role_model, :performance, :explanation_script, :prompt_script, :model_script
  json.url lesson_url(lesson, format: :json)
end
