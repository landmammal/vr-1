class LessonExplanationsController < ApplicationController

	def index
		@lessonExp = LessonExplanation.all
		@lessonPrm = LessonPrompt.all
		@lessonMdl = LessonModel.all
		@courseReg = CourseRegistration.all

	end

	def delete
		@lessonExp = LessonExplanation.find(params[:id])
		binding.pry
	end

end