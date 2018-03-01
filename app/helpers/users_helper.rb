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


  def course_trainee
    if current_user.registered_courses.include? @course
      access = true
    else
      access = false
    end
    return access
  end

  def course_pending
    pending = false

    cr = @course.course_registrations.find_by(user_id: current_user.id)
    if cr
      pending = true if cr.approval_status == false
    end

    pending
  end

  def registered_lessons
    @registered_courses = current_user.registered_courses
    lessons_count = 0
    @registered_courses.each do |course|
      course.topics.each { |topic| lessons_count += topic.lessons.size }
    end
    return lessons_count.to_s
  end

end
