json.array!(@topics) do |topic|
  json.extract! topic, :id, :topic_title, :description
  json.url topic_url(topic, format: :json)
end
