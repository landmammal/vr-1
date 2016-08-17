class RehearsalsController < ApplicationController
  before_action :set_rehearsal, only: [:show, :edit, :destroy, :update]
  before_action :set_lesson, only: [:create]
  before_action :set_topic, only: [:update]
  before_action :set_course, only: [:update]

  def index
    @rehearsals = Rehearsal.all
  end

  def all
    @rehearsals = Rehearsal.all
  end

  def show
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
    @rehearsal.submission = true
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
    binding.pry
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_rehearsal
    @rehearsal = Rehearsal.find(params[:id])
  end

  def rehearsal_params
    params.require(:rehearsal).permit(:course_id, :lesson_id, :group_id, :token, :video_token, :trainee_id, :script, :submission)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
