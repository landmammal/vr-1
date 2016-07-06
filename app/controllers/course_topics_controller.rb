class CourseTopicsController < ApplicationController

  def index
    @course_topics = CourseTopic.all
  end
end
