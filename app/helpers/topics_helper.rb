module TopicsHelper

	def topic_lesson_completion(lesson)
		rehearsals = current_user.rehearsals.where(lesson_id: lesson.id, submission: true)
		rehearsals.size > 0 ? @lesson_done = 0 : @lesson_done = false
		
		rehearsals.each do |rehearsal|
			feedback_approved = 0

			rehearsal.feedbacks.each { |feedback| feedback_approved += 1 if feedback.approved == true }

			if rehearsal.feedbacks.size > 0
				feedback_approved > (rehearsal.feedbacks.size * 0.75) ? @lesson_done = 1 : @lesson_done = 2
			else
				@lesson_done = 0
			end

		end

		# binding.pry

		return @lesson_done
	end

	def topic_lesson_status(lesson)
		explanations = lesson.explanations
		explanation_check = 0
		explanations.each do |explanation|
			explanation_check += 1 if (explanation.position_prior == 1 && explanation.video_token != '')
		end

		prompts = lesson.prompts
		prompt_check = 0
		prompts.each do |prompt|
			prompt_check += 1 if (prompt.position_prior == 1 && prompt.video_token != '')
		end

		models = lesson.models
		model_check = 0
		models.each do |model|
			model_check += 1 if (model.position_prior == 1 && model.video_token != '')
		end

		if (lesson.lesson_type.to_i == 0 || lesson.lesson_type == nil) && explanation_check > 0 && prompt_check > 0 && model_check > 0
			@lesson_check = true
		elsif lesson.lesson_type.to_i == 1 && explanation_check > 0 && model_check > 0
			@lesson_check = true
		elsif lesson.lesson_type.to_i == 2 && explanation_check > 0 && prompt_check > 0
			@lesson_check = true
		else
			@lesson_check = false
		end

		return @lesson_check
	end

end