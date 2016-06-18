module PracticesHelper

  def progress
    complete = current_user.practices.count
    total = current_user.practices.last.lesson.chapter.course.lessons.count

    percent = (complete / total ) * 100
    p percent

  end

end
