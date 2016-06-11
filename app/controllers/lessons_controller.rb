class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chapter, except: [:index, :show]
  before_action :set_lesson, only: [ :edit, :update, :destroy]


  # GET /lessons
  # GET /lessons.json
  def index

    # @lessons = @chapter.lessons.all
    # if @lessons
    # else

    @lessons = Lesson.all

  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson = Lesson.find(params[:id])
  end

  # GET /lessons/new
  def new

    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = @chapter.lessons.build(lesson_params)

    if @lesson.save
      respond_to do |format|
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    # if @lesson.user_id == current_user
      @lesson.destroy
      respond_to do |format|
        format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
        format.json { head :no_content }
      end
    # else
      # flash[:alert] = "You do not have permission to delete this lesson."
    end
  end

  private

    # set the chapter you are in before you start adding lessons
    def set_chapter
      @chapter = Chapter.find(params[:chapter_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = @chapter.lessons.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:course_id, :topic_id, :lesson_title, :explanation, :prompt, :role_model, :performance, :explanation_script, :prompt_script, :model_script)
    end
end
