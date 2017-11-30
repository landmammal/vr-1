class AdminMailer < ApplicationMailer
  add_template_helper(EmailHelper)
  default from: '\'Video Rehearser\' <notification@videorehearser.com>'
  before_action :set_base_url

  # sending admin mail when a new user registers
  def new_user_waiting_for_approval
    @url  = @base+'/users/sign_in'
    mail(to: 'carlos@videorehearser.com', subject: "New User Signup")
  end

  # sending user welcoming email
  def user_register_notice(user)
    @user = user
    @url = @base+'/users/sign_in'
    mail( to: @user.email, subject: "Thanks for signing up!")
  end

  def invite_to_course(user, course, url)
    @user = user
    @course = course
    @lessons = 0
    course.topics.each { |t| @lessons += t.lessons.size }
    
    @instructor = course.instructor
    invite = user.course_registrations.where( course_id: course.id )
    @url = @base+url
    mail( to: @user.email, subject: "#{user.full_name}, welcome to #{course.title} on videoRehearser")
  end

  def invite_to_website(email, course)
    @email = email
    @course = course
    @url = @base
    @course_url = @base+"/courses/"+course.id.to_s
    mail( to: email, subject: "Welcome to the vR Community #{email}!")
  end


  def send_job_application( app )
    @app = app
    mail( to: "carlos@videorehearser.com", subject: "vR Job Application from #{ app['first_name'] } #{ app['last_name'] }!")
  end

  def rehearsal_sent( rehearsal )
    @student = rehearsal.trainee
    @rehearsal = rehearsal
    @instructor = rehearsal.lesson.instructor
    @lesson_url = @base+rehearsal.lesson.path
    @student_url = @base+"/rehearsals/student/?student="+@student.id.to_s+"&lesson="+rehearsal.lesson.id.to_s
    mail( to: @instructor.email, subject: "Rehearsal Subimitted by #{@student.full_name}!")
  end

  # sending approval update to user
  def user_approved_notice(user)
    @url = @base+'/users/sign_in'
    @user = user
    mail(from: '\'Carlos Vazquez\' <notification@videorehearser.com>', to: @user.email, subject: "Welcome to vR!")
  end

  # sending notification to trainee that they have a new feedback available
  def feedback_notice(user)
    @url = @base+'/users/sign_in'
    @user = user
    mail( to: @user.email, subject: "You got feedback.")
  end

  # sending trainee and email notifying them of a lesson completed
  def lesson_complete_notice(user, status, message, lesson)
    @url = @base+'/courses/'+lesson.topic.course.id.to_s+'/topics/'+lesson.topic.id.to_s+'/lessons/'+lesson.id.to_s
    @user = user
    @lesson = lesson
    @status = status
    @message = message
    mail( to:@user.email, subject: message )
  end

  # sending mail to team with information on a new lead up
  def lead_notice(user)
    @url = @base+'/users/sign_in'
    @user = user
    mail( to:'carlos@videorehearser.com', subject: "#{user.first_name} #{user.last_name} #red @jcvazquez6")
  end

  def set_base_url
    if Rails.env.development?
      @base = "http://localhost:3000"
    else
      @base = "https://videorehearser.herokuapp.com"
    end
  end
end