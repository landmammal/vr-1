class RehearsalsController < ApplicationController
  before_action :set_rehearsal, only: [:show, :edit, :destroy, :update]
  before_action :set_lesson, only: [:create]

  # before_action :set_topic, only: [:update]
  # before_action :set_course, only: [:update]

  # def index
  #   @rehearsals = Rehearsal.all
  #   @feedback = Feedback.new
  #   @performance_feedback = PerformanceFeedback.new
  # end

  def index

    @feedback = Feedback.new
    @performance_feedback = PerformanceFeedback.new

    @course_rehearsals = []
    current_user.courses.each { |course| course.rehearsals.each { |c| @course_rehearsals << c if c.submission == true } if course.rehearsals.size > 0 }
    @topic_rehearsals = []
    current_user.topics.each { |topic| topic.rehearsals.each { |t| @topic_rehearsals << t if t.submission == true } if topic.rehearsals.size > 0 }
    @lesson_rehearsals = []
    current_user.lessons.each { |lesson| lesson.rehearsals.each { |l| @lesson_rehearsals << l if l.submission == true } if lesson.rehearsals.size > 0 }



  end

  def show
    # @new_feedback = Feedback.new
    @feedback = Feedback.new
    @performance_feedback = PerformanceFeedback.new
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
        format.js {  }
        format.html { redirect_to @rehearsal, notice: 'Rehearsal was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @rehearsal.submission = nil
      @rehearsal.submission = true
    else
      @rehearsal.submission = false
    end
    respond_to do |format|
      if @rehearsal.save!
        format.html { redirect_to course_topic_path(@course, @topic), notice: 'Rehearsal was successfully updated.' }
      else
        binding.pry
      end
    end
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

  def rehearsal_params
    params.require(:rehearsal).permit(:course_id, :lesson_id, :group_id, :token, :video_token, :trainee_id, :script, :submission, :topic_id)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
