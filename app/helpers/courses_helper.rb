module CoursesHelper

	def course_trainee
		if current_user.registered_courses.include? @course
			access = true
		else
			access = false
		end
		return access
	end

	def course_puplic
		access = true if @course.privacy == 0
		return access
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

	def instructor_name
		@instructor = User.find(@course.instructor_id)
		instructor_f = @instructor.first_name
		instructor_l = @instructor.last_name
		instructor_fullname = instructor_f+" "+instructor_l

		return instructor_fullname
	end

end
