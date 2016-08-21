class CourseRegistrationsController < ApplicationController

  def new
    @course_registration = CourseRegistration.new
  end
  
	def create
		@course_registration = CourseRegistration.create(course_regis_params)

		render json: @course_registration
	end

	private

	def course_regis_params
		params.permit(:user_id, :course_id, :user_role)
	end

end
