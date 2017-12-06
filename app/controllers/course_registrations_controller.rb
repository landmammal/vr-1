class CourseRegistrationsController < ApplicationController
	before_action :set_course, only: [:create, :destroy]
	before_action :set_course_registration, only: [:destroy, :update, :edit]

	def index
		@courses_users_register_to = []
		current_user.courses.order('updated_at DESC').each { |course| course.course_registrations.each { |cr| @courses_users_register_to << cr if cr.approval_status == false } }
	end

	def create
		cr = @course.course_registrations.find_by( user_id: current_user.id )
		if !cr
			if @course.free?
				create_it(@course)				
				@created = true
			elsif @course.with_code?
				if params[ :access_code ] == @course.access_code
					create_it(@course)				
				end
				@created = true
			else
				@created = false
			end

			respond_to do |format|
				format.js{ }
			end

		end	
	end

	def create_it(course)
		@cr = current_user.course_registrations.build(course_regis_params)
		@cr.course_id = course.id
		@cr.user_role = User.roles[current_user.role]
		course.private? ? @cr.approval_status = false : @cr.approval_status = true
		@cr.save
		@cr
	end

	def edit

	end

	def update
		@course_registration.approval_status = true
		respond_to do |format|
			if @course_registration.save
				format.js { flash.now[:notice] = "Student Accepted" }
			else
				format.html { render :edit }
				format.json { render json: @course.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@course_registration.destroy
		respond_to do |format|
			format.js { flash.now[:notice] = "Student Rejected" }
		end
	end

	private
	def registration_approved
		params.require(:course_registration).permit(:approval_status)
	end
	
	def set_course_registration
		@course_registration = CourseRegistration.find(params[:id])
	end

	def set_course
		@course = Course.find(params[:course_id])
	end

	def course_regis_params
		params.permit(:user_role)
	end

end
