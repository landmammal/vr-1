json.array!(@rehearsals_api) do |rehearsal|
  json.extract! rehearsal, :id, :video_token, :trainee_id
  json.url course_url(rehearsal, format: :json)
end
