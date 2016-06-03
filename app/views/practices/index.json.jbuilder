json.array!(@practices) do |practice|
  json.extract! practice, :id, :token, :video_token, :completed, :user_id
  json.url practice_url(practice, format: :json)
end
