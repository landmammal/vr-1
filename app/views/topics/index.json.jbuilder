json.array!(@topics) do |topic|
  json.extract! topic, :id, :title, :description, :course_id
  json.url course_topic_url(topic, format: :json)
end
