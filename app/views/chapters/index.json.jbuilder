json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :course_id, :chapter_title, :description
  json.url chapter_url(chapter, format: :json)
end
