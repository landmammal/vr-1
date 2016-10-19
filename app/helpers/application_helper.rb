module ApplicationHelper

  def getDateTime(date)
    return date.strftime("%m/%d/%Y at %I:%M%p")
  end

  def getDate(date)
    return date.strftime("%m/%d/%Y")
  end

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
      if (rehearsal.feedbacks.size < 1 && rehearsal.approval_status == 0) || (rehearsal.feedbacks.size > 1 && rehearsal.approval_status == 1) && User.exists?(rehearsal.trainee_id) 
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
