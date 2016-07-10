class ApiController < ApplicationController	
	def courses_api
		@courses = Course.all
		render json: @courses
	end
	def topics_api
		@topic = Topic.all
		render json: @topic
	end
	def lessons_api
		@lesson = Lesson.all
		render json: @lesson
	end
end