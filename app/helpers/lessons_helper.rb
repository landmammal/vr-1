module LessonsHelper
	def total_lessons
		@registered_courses = current_user.registered_courses
		lessons_count = 0
		@registered_courses.each do |course|
			course.topics.each { |topic| lessons_count += topic.lessons.size }
		end
		return lessons_count.to_s
	end
	def lessons_completed
		registered_courses = current_user.registered_courses
		user_rehearsals = current_user.rehearsals.where(submission: true)

		completed_lessons = {}
		completed_lessons_count = 0

		user_rehearsals.each do |rehearsal|
			if registered_courses.include? rehearsal.course
				completed_lessons[rehearsal.lesson.id.to_s+' - '+rehearsal.lesson.title] = 0
				rehearsal.feedbacks.each do |feedback|
					completed_lessons[rehearsal.lesson.id.to_s+' - '+rehearsal.lesson.title] = 1 if feedback.approved
				end
			end
		end

		completed_lessons.each { |key, item| completed_lessons_count += item }

		return completed_lessons_count.to_s
	end


	def rehearsals_for_this_lesson
		@rehearsals_for_this_lesson = @lesson.rehearsals.where(trainee_id: current_user.id).order("id ASC")
		return @rehearsals_for_this_lesson
	end

	def hasVideoToken(element)
		return (element.video_token == '' || element.video_token.nil?)
	end


	def LessonNextPrevious(lesson)
		topic = lesson.topic # CHANGE when interchanging lessons with other topics
		lesson_list = []
		next_previous = [0,1]

		topic.lessons.order('id ASC').each { |lesson| lesson_list << lesson.id }
		# Make difference between instructor and Trainnee
		#CHANGE when able to reorder lessons 
		
		thisIdIndex = lesson_list.index(lesson.id)

		lesson_list.last == lesson.id ? next_previous[1] = false : next_previous[1] = lesson_list[thisIdIndex+1]
		thisIdIndex == 0 ? next_previous[0] = false : next_previous[0] = lesson_list[thisIdIndex-1]

		return next_previous
	end
end