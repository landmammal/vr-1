module TopicsHelper

	def topic_lesson_status(lesson)
		lType = lesson.lesson_type
		check = [[lesson.explanations, false],[lesson.prompts, false],[lesson.models, false]]

		check.each do |item|
			item[0].each do |itemcheck|
				if itemcheck.position_prior == 1 && itemcheck.video_token!=nil
					item[1] = true if itemcheck.video_token!=''
				end
			end
		end

		if (lType.to_i == 0 || lType == nil) && check[0][1] && check[1][1] && check[2][1]
			@lesson_check = true
		elsif lType.to_i == 1 && check[0][1] && check[2][1]
			@lesson_check = true
		elsif lType.to_i == 2 && check[0][1] && check[1][1]
			@lesson_check = true
		else
			@lesson_check = false
		end

		return @lesson_check
	end

end