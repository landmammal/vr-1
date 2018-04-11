class RehearsalsController < ApplicationController
  include RehearsalsHelper
  
  before_action :set_rehearsal, only: [:edit, :destroy]
  before_action :set_update_rehearsal, only: [:update]
  before_action :set_lesson, only: [:create, :index]
  before_action :set_lesson_rehearsal, only: [:show]
  before_action :authenticate_user!

  require 'rest-client'

  def index
    if params[:lesson_id]
      if params[:trainee_id]
        @student = User.find(params[:trainee_id])
        @lesson = Lesson.find(params[:lesson_id])
        @rehearsals = @lesson.rehearsals.where(trainee_id: params[:trainee_id], submission: true)
      else
        @rehearsals = Rehearsal.where( lesson_id: params[:lesson_id] )
      end
    else
      @rehearsals = Rehearsal.all
      @rehearsals_api = Rehearsal.all
      @feedback = Feedback.new
      @performance_feedback = PerformanceFeedback.new
    end

    respond_to do |format| 
      format.html { }
      format.js { }
    end
  end


  def all
    @courses = current_user.courses.all
  end


  def student
    # @student = User.find(params[:student])
    # @lesson = Lesson.find(params[:lesson])
    # @rehearsals = @lesson.rehearsals.where(trainee_id: params[:student], submission: true)
  end

  def trainees
    if params[:lesson_id]
      rehearsal_trainee_ids = Rehearsal.where( lesson_id: params[:lesson_id], submission: true ).map{ |x| x.trainee_id }.compact.uniq
      @lesson = Lesson.find(params[:lesson_id])
      @trainees = User.where( id: rehearsal_trainee_ids )
    else
      @trainees = nil
    end

    respond_to do |format|
      format.js { }
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

        format.js {}
      else
        format.html { render :new }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    @rehearsal.submission = params[:rehearsal][:submission] if params[:rehearsal][:submission] != nil
    @rehearsal.approval_status = params[:rehearsal][:approval_status] if params[:rehearsal][:approval_status] != nil
    @rehearsal.instructor_rating = params[:rehearsal][:instructor_rating] if params[:rehearsal][:instructor_rating] != nil
    @rehearsal.self_rating = params[:rehearsal][:self_rating] if params[:rehearsal][:self_rating] != nil

    @change = @rehearsal.changed[0..5]

    if @rehearsal.update(rehearsal_update_params)
      respond_to do |format|
        format.js {} 
      end
    end
  end

  def destroy
    LessonRehearsal.where(rehearsal_id: @rehearsal).destroy_all 
    PerformanceFeedback.where(rehearsal_id: @rehearsal).destroy_all 
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
    params.require(:rehearsal).permit(:course_id, :lesson_id, :group_id, :token, :video_token, :trainee_id, :script, :submission, :topic_id, :instructor_rating, :refnum, :self_rating)
  end

  def rehearsal_update_params
    params.require(:rehearsal).permit(:approval_status, :submission, :instructor_rating, :self_rating)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_lesson_rehearsal
    @rehearsal = Rehearsal.find(params[:id])
    @lesson = Lesson.find(@rehearsal.lesson_id)
  end
end
