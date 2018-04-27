module LessonsHelper
	
	def lessons_completed
		registered_courses = current_user.registered_courses
		finished = []
		registered_courses.each do |course|
			course.topics.each do |topic|
				topic.lessons.each do |lesson|
					finished << lesson if lesson.completion_status(current_user)[0] == "approved"
				end
			end
		end

		return finished.size.to_s
	end

	def first_lesson_path( course )
		if course.topics.size > 0 && course.topics.first.lessons.size > 0
			"/courses/#{course.id}/topics/#{course.topics.first.id}/lessons/#{course.topics.first.lessons.first.id}"
		else
			"/courses/#{course.id}"
		end
	end

	def component(item)
		ready = [false,false]

		ready[1]=true if (item.position_prior == 1 && item.video_token!=nil)
		ready[0]=true if item.video_token!=''

		return ready
	end


	def rehearsals_for_this_lesson
		@rehearsals_for_this_lesson = @lesson.rehearsals.where(trainee_id: current_user.id).order("id DESC")
		return @rehearsals_for_this_lesson
	end

	# CHECK WHERE THIS IS BEING USED
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


	def TopicNextPrevious(topic)
		course = topic.course # CHANGE when interchanging topics with other courses
		topic_list = []
		next_previous = [0,1]

		course.topics.order('id ASC').each { |topic| topic_list << topic.id }
		# Make difference between instructor and Trainnee
		#CHANGE when able to reorder topics 
		
		thisIdIndex = topic_list.index(topic.id)

		topic_list.last == topic.id ? next_previous[1] = false : next_previous[1] = topic_list[thisIdIndex+1]
		thisIdIndex == 0 ? next_previous[0] = false : next_previous[0] = topic_list[thisIdIndex-1]

		return next_previous
	end
end