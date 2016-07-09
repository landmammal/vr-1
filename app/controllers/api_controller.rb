class ApiController < ApplicationController	
	def courses_api
		@courses = Course.all
		render json: @courses
	end
end