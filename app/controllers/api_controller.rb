class ApiController < ApplicationController	
	def courses_api
		@courses = Course.all
		render json: @courses
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


	# LEFT PANEL LINKS


	def site_panel_api
		@site_panel = [{name:'Home', icon:'svg', iname:'home', link:user_path(current_user), link_target:'', notif:false},
                       {name:'Settings', icon:'svg', iname:'settings', link:edit_user_registration_path, link_target:'', notif:false}]
        render json: @site_panel
        # edit_user_registration_path
	end
	
	def common_panel_api
		@common_panel = [{name:'Chat', icon:'svg', iname:'chat', link:'#', link_target:'', notif:true},
                         {name:'Courses', icon:'ion', iname:'ion-map', link:search_courses_path, link_target:'', notif:false},
                         {name:'Tasks', icon:'ion', iname:'ion-android-checkbox-outline', link:'#', link_target:'', notif:true}]
        render json: @common_panel
	end

	def instructor_panel_api
		@instructor_panel = [{name:'My Courses', icon:'ion', iname:'ion-university', link:courses_path, link_target:'', notif:false},
                         {name:'My Tools', icon:'ion', iname:'ion-settings', link:'#', link_target:'', notif:false},
                         {name:'Rehearsals', icon:'ion', iname:'ion-android-list', link:rehearsals_all_path, link_target:'', notif:false}]
        render json: @instructor_panel
	end

end