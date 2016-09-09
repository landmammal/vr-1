class CourseRegistrationsController < ApplicationController
	before_action :set_course, only: [:create]

	def index
		@course_regs = CourseRegistration.all
	end

	def create
		@course_registration = current_user.course_registrations.build(course_regis_params)
		@course_registration.course_id = @course.id
		@course_registration.user_role = User.roles[current_user.role]
		
		if @course_registration.save
      		render json: @course_registration
		end
	end

	def delete
		c_reg = CourseRegistration.find(params[:id])

		if c_reg.destroy
			redirect_to '/courseregistrations/'
		end
		
	end

	private
	def set_course
		@course = Course.find(params[:course_id])
	end

	def course_regis_params
		params.permit(:user_role)
	end

end
