module ApplicationHelper

  # def progress
  #   if current_user.practices.empty?
  #     0
  #   else
  #     complete = current_user.practices.count
  #     total = current_user.practices.last.lesson.topic.course.lessons.count
  #
  #     percent = complete * 100.00 / total
  #     (percent > 100) ? 100 : percent.round
  #   end
  # end

  def feedback_notif
    @all_rehearsals = current_user.rehearsals
    @feedback_notif = 0

    @all_rehearsals.each do |rehearsal|
      rehearsal.feedbacks.each do |rhf|
        @feedback_notif += 1 if !rhf.viewed_by_user
      end
    end

    return @feedback_notif
  end

  def rehearsals_notif
    @course_rehearsals = []
    current_user.courses.each { |course| course.rehearsals.each { |c| @course_rehearsals << c if c.submission == true } if course.rehearsals.size > 0 }
    
    @rehearsals_without_feedback = []

    @course_rehearsals.each do |rehearsal| 
      if rehearsal.feedbacks.size < 1 
        @rehearsals_without_feedback << rehearsal
      end
    end 

    return @rehearsals_without_feedback.count.to_s
  end

  def demo_notif
    @demos = Demo.all
    return @demos
  end

  def chat_notif
    @chat = 0
    return @chat
  end

  def tasks_notif
    @tasks = Task.all.count.to_s
    return @tasks
  end
  
end
