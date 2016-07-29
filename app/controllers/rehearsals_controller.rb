class RehearsalsController < ApplicationController
  before_action :set_rehearsal, only: [:show, :edit, :update, :destroy]
  before_action :set_lesson, only: [:new]

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
    @lesson = Lesson.find(params[:lesson_id])
    @lesson.rehearsals.build(rehearsal_params)
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @rehearsal, notice: 'Rehearsal was successfully created.' }
        format.json { render :show, status: :created, location: @rehearsal }
      else
        format.html { render :new }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rehearsal.update(rehearsal_params)
        format.html { redirect_to @rehearsal, notice: 'Rehearsal was successfully updated.' }
        format.json { render :show, status: :ok, location: @rehearsal }
      else
        format.html { render :edit }
        format.json { render json: @rehearsal.errors, status: :unprocessable_entity }
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

    def set_rehearsal
      @rehearsal = Rehearsal.find(params[:id])
    end

    def rehearsal_params
      params.require(:rehearsal).permit(:course_id, :progress_id, :group_id, :course_number, :token, :video_token, :trainee_id, :script)
    end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
