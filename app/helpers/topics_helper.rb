module TopicsHelper

	def lesson_completed
		@rehearsal_done = Rehearsal.where(topic_id: @topic.id)
		@lesson_done = true if @rehearsal_done.size > 0
		return @lesson_done
	end

end