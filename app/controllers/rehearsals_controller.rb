class RehearsalsController < ApplicationController
  include RehearsalsHelper
  before_action :set_rehearsal, only: [:edit, :destroy]
  before_action :set_update_rehearsal, only: [:update]
  before_action :set_lesson, only: [:create, :index]
  before_action :set_lesson_rehearsal, only: [:show]
  before_action :authenticate_user!

  require 'rest-client'

  # approving  a rehearsal
  # def rehearsal_approved
  #   @rehearsal = Rehearsal.find(params[:rehearsal_id])
  #   @rehearsal.approval_status = 1
  #   user = @rehearsal.trainee
  #   respond_to do |format|
  #     if @rehearsal.save!
  #       AdminMailer.lesson_complete_notice(user).deliver_now
  #       format.js { render :js => "window.location = '/rehearsals/all'" }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def approved
    @rehearsal = Rehearsal.find(params[:rehearsal_id])
    # puts "===================LOADED================="
    @rehearsal.approval_status = params[:approval_status]
    user = @rehearsal.trainee
    respond_to do |format|
      if @rehearsal.save!
        # admin mailer must be put on hold until we find a better way to do a redo
        # AdminMailer.lesson_complete_notice(user).later
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @rehearsals = Rehearsal.all
    @rehearsals_api = Rehearsal.all
    @feedback = Feedback.new
    @performance_feedback = PerformanceFeedback.new
  end

  # def all
  #   @courses = []

  #   @rehearsals = []
  #   @students = {}

  #   current_user.courses.each do |course|
  #     course.rehearsals.where(submission: true).each do |rehearsal|
  #       if User.all.include? rehearsal.trainee 
  #         @students[rehearsal.trainee]=[]
  #       end
  #     end
  #     course.rehearsals.where(submission: true).each do |rehearsal|
  #       if params[:list] == "all"
  #         @rehearsals << rehearsal
  #         @re_title = "All Rehearsals"
  #         @students[rehearsal.trainee] << rehearsal
  #       elsif !params[:student].blank?
  #         if rehearsal.trainee_id = params[:student].to_i
  #           @rehearsals << rehearsal
  #         end
  #       else
  #         if (rehearsal.feedbacks.size < 1 && rehearsal.approval_status == 0) || (rehearsal.feedbacks.size > 1 && rehearsal.approval_status == 1) && User.exists?(rehearsal.trainee_id)
  #           @re_title = "Rehearsals"
  #           @rehearsals << rehearsal
  #           @students[rehearsal.trainee] << rehearsal
  #         end
  #       end
  #       @courses<<rehearsal.course if !@courses.include? rehearsal.course
  #     end
  #   end
  # end


  def all

    @courses = {}
    current_user.courses.each do |course|
      @courses[course.title] = {}
      @courses[course.title]["course"] = course
      @courses[course.title]["topics"] = {}

      course.topics.each do |topic|
        @courses[course.title]["topics"][topic.title] = {}
        @courses[course.title]["topics"][topic.title]["topic"] = topic
        @courses[course.title]["topics"][topic.title]["lessons"] = {}

        topic.lessons.each do |lesson|
          @courses[course.title]["topics"][topic.title]["lessons"][lesson.title] = {}
          @courses[course.title]["topics"][topic.title]["lessons"][lesson.title]["lesson"] = lesson
          @courses[course.title]["topics"][topic.title]["lessons"][lesson.title]["rehearsals"] = {}

          lesson.rehearsals.each do |x|
            if User.all.include? x.trainee
              @courses[course.title]["topics"][topic.title]["lessons"][lesson.title]["rehearsals"][x.trainee.full_name] = {
                "student_id" => x.trainee_id,
                "image" => student_pic(x.trainee),
                "lesson_info" => [ lesson.title, lesson.id ],
                "rhs_count" => x.trainee.rehearsals.where( lesson_id: lesson.id).where( submission: true ).size,
                "new_count" => x.trainee.rehearsals.map{ |x| x if (  x.lesson_id == lesson.id && x.new? )   }.size
              }
            end
          end

        end

      end
    end

  end


  def student
    @student = User.find(params[:student])
    @lesson = Lesson.find(params[:lesson])
    @rehearsals = @lesson.rehearsals.where(trainee_id: params[:student], submission: true)
  end

  def show
    @feedback = Feedback.new
    @performance_feedback = PerformanceFeedback.new
    @otherrehearsals = @rehearsal.lesson.rehearsals.where(submission: true).order('id DESC')
  end

  def new
    @rehearsal = Rehearsal.new
  end

  def edit
  end

  def create
    @rehearsal = @lesson.rehearsals.build(rehearsal_params)
    respond_to do |format|
      if @lesson.save
        @rehearsal = @lesson.rehearsals.last

        # headers = {content_type: :json, accept: :json, app_id: '4985f625', app_key: '4423301b832793e217d04bc44eb041d3'}

        # kairos = RestClient.post("https://api.kairos.com/v2/media?source=https://embed-cdn.ziggeo.com/v1/applications/5b2dedd0371b8806b7f81390a7555653/videos/26cda86833d2458025e46b2df33cf55d/video.mp4" , headers={content_type: :json, accept: :json, app_id: '4985f625', app_key: '4423301b832793e217d04bc44eb041d3'})
        # sleep 6

        # puts "==================================="
        # puts kairos
        # puts "==================================="

        # binding.pry

        format.js {}
      else
        format.html { render :new }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    (!@rehearsal.submission || @rehearsal.submission == nil) ? @rehearsal.submission = true : @rehearsal.submission = false

    @rehearsal.approval_status = 0
    @rehearsal.save
    render json: @rehearsal
  end

  def destroy
    @rehearsal.destroy
    respond_to do |format|
      format.html { redirect_to rehearsals_url, notice: 'Rehearsal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_rehearsal
    @rehearsal = Rehearsal.find(params[:id])
  end

  def set_update_rehearsal
    @rehearsal = Rehearsal.find(params[:id])
  end

  def rehearsal_params
    params.require(:rehearsal).permit(:course_id, :lesson_id, :group_id, :token, :video_token, :trainee_id, :script, :submission, :topic_id)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_lesson_rehearsal
    @rehearsal = Rehearsal.find(params[:id])
    @lesson = Lesson.find(@rehearsal.lesson_id)
  end
end
