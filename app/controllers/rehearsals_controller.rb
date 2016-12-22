class RehearsalsController < ApplicationController
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
        AdminMailer.lesson_complete_notice(user).deliver_now
        format.js { }
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

  def all
    # @feedback = Feedback.new
    # @performance_feedback = PerformanceFeedback.new

    # @course_rehearsals = []
    # current_user.courses.order('updated_at DESC').each { |course| course.rehearsals.each { |c| @course_rehearsals << c if c.submission == true } if course.rehearsals.size > 0 }
    # @topic_rehearsals = []
    # current_user.topics.order('updated_at DESC').each { |topic| topic.rehearsals.each { |t| @topic_rehearsals << t if t.submission == true } if topic.rehearsals.size > 0 }
    # @lesson_rehearsals = []
    # current_user.lessons.order('updated_at DESC').each { |lesson| lesson.rehearsals.each { |l| @lesson_rehearsals << l if l.submission == true } if lesson.rehearsals.size > 0 }

    # @user_feedback = current_user.feedbacks.order('updated_at DESC').select(:id)
    
    # @rehearsals_without_feedback = []
    # @rehearsals_with_feedback = []
    # @rehearsals_to_check = Rehearsal.where(approval_status: 0)

    # @course_rehearsals.each do |rehearsal| 
    #   if rehearsal.feedbacks.size < 1
    #     @rehearsals_without_feedback << rehearsal
    #   else
    #     @rehearsals_with_feedback << rehearsal
    #   end
    # end 

    # @courses = current_user.courses;
    @courses = [];

    @rehearsals = []
    
    current_user.courses.each do |course|
      course.rehearsals.where(submission: true).each do |rehearsal|
        if params[:list] == "all"
            @rehearsals << rehearsal
            @courses<<rehearsal.course if !@courses.include? rehearsal.course
            @re_title = "All Rehearsals"
        else
          if (rehearsal.feedbacks.size < 1 && rehearsal.approval_status == 0) || (rehearsal.feedbacks.size > 1 && rehearsal.approval_status == 1) && User.exists?(rehearsal.trainee_id) 
            @courses<<rehearsal.course if !@courses.include? rehearsal.course
            @re_title = "Rehearsals"
            @rehearsals << rehearsal
          end
        end
      end
    end

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

        format.js {  }
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
