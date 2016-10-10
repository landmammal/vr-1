class ApiController < ApplicationController

	# api call from groups/all_groups
	def group_single_api
		@group = Group.find(params[:id])
		render json: @group
	end

	def courses_api
		@courses = Course.all
		render json: @courses
	end

	def rehearsals_api
		@rehearsals = Rehearsal.all
	    render json: @rehearsals
	end

	def feedback_create
		binding.pry
		rehearsal = Rehearsal.find(params[:rehearsal_id])
    	feedback = rehearsal.feedbacks.build(feedback_params)
    	rehearsal.save
    	@feedback = rehearsal.feedback.last

	    render json: @feedback
	end
	
	def rehearsals_single_api
		@rehearsal = Rehearsal.find(params[:id])
	    render json: @rehearsal
	end

	def course_registrations_single
		@course_registration = CourseRegistration.find(params[:id])
	end

	def course_registrations_api

		@course_registrations = CourseRegistration.all
		render json: @course_registrations
	end
	def topics_api
		@topic = Topic.all
		render json: @topic
	end
	def lessons_api
		@lesson = Lesson.all
		render json: @lesson
	end
	def demos_api
		@demos = Demo.all
		render json: @demos
	end

	def tasks_api
		@tasks = Task.all
		render json: @tasks
	end

	def feedback_api
		@all_rehearsals = current_user.rehearsals.select(:id, :course_id)
		@feedback_notif = []
		@all_rehearsals.each { |rehearsal| @feedback_notif << rehearsal if rehearsal.feedbacks.count > 0 }

		render json: @feedback_notif
	end

	def chat_api
		@demos = Demo.all
		render json: @demos
	end


	# LEFT PANEL LINKS


	def site_panel_api
		@site_panel = [{name:'Home', icon:'ion', iname:'ion-home', link:user_path(current_user), link_target:'', notif:false},
                       {name:'Settings', icon:'ion', iname:'ion-ios-gear', link:edit_user_registration_path, link_target:'', notif:false}]
        render json: @site_panel
        # edit_user_registration_path
	end

	def common_panel_api
		@common_panel = [{name:'Courses', icon:'ion', iname:'ion-map', link:search_courses_path, link_target:'', notif:false},
										 {name:'Feedback', icon:'ion', iname:'ion-archive', link:feedback_all_path, link_target:'', notif:true},
										 {name:'Tasks', icon:'ion', iname:'ion-android-checkbox', link:'#', link_target:'', notif:true},
										 {name:'Chat', icon:'ion', iname:'ion-android-chat', link:'#', link_target:'', notif:true},
										 {name:'Groups', icon:'#', iname:'#', link:groups_all_groups_path, link_target:'', notif:false}]
        render json: @common_panel
	end

	def instructor_panel_api
		@instructor_panel = [{name:'My Courses', icon:'ion', iname:'ion-university', link:courses_path, link_target:'', notif:false},
                         {name:'My Tools', icon:'ion', iname:'ion-settings', link:'#', link_target:'', notif:false},
                         {name:'Rehearsals', icon:'ion', iname:'ion-android-list', link:rehearsals_all_path, link_target:'', notif:true}]
        render json: @instructor_panel
	end

	def admin_panel_api
		@admin_panel = [{name:'Demos', icon:'ion', iname:'ion-social-youtube', link:demos_path, link_target:'', notif:true}]
        render json: @admin_panel
	end

	private

	def feedback_params
	    params.require(:feedback).permit(:user_id, :notes, :token, :video_token, :review_satatus, :concept_review, :video_type, :approved, :rehearsal_id)
	end
end
