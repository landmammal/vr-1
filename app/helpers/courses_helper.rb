module CoursesHelper

	def content(course)
		thisCourse = {topics: 0, lessons: 0, content:[]}
		thisCourse[course.title] = {}
		lessons = []
		
		course.topics.each do |topic|
			topic.lessons.each { |lesson| lessons << lesson }
			thisCourse[:content] << topic
		end
		
		thisCourse[:topics] = course.topics.size
		thisCourse[:lessons] = lessons.size

		return thisCourse
	end

	def rehearsals_done
		@comp_rehears = Rehearsal.where(course_id: @course.id, topic_id: topic.id)
		return @comp_rehears.size.to_s
	end

	def instructor_profile
		@instructor = User.find(@course.instructor_id)
		@instructor.profile_file_name.present? ? profile = @instructor.profile.url(:square) : profile = '/assets/default_user.png'
		instructor_pic = profile

		return instructor_pic
	end
end
