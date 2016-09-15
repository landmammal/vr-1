module UsersHelper

  def course_creator
    access = true if current_user.id == @course.instructor_id || current_user.level_1
    return access
  end
  def topic_creator
  	access = true if current_user.id == @topic.instructor_id || current_user.level_1
  	return access
  end
  def lesson_creator
    access = true if current_user.id == @lesson.instructor_id || current_user.level_1
    return access
  end

end
