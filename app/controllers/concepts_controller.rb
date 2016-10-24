class ConceptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_concept, only: [:edit, :destroy, :update]


  def new
    @concept = Concept.new
  end

  def create
    @lesson = current_user.lessons.find(params[:lesson_id])
    @lesson.concepts.build(concept_params)

    respond_to do |format|
      if @lesson.save
        @concept = Concept.find(@lesson.concepts.last.id)
        @lesson = Lesson.find(@concept.lesson_id)
        @topic = Topic.find(@lesson.topic_id)
        @course = Course.find(@topic.course_id)
        format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson) }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
       if @concept.update(concept_update)
         @concept = Concept.find(params[:id])
         @lesson = Lesson.find(@concept.lesson_id)
         @topic = Topic.find(@lesson.topic_id)
         @course = Course.find(@topic.course_id)
         format.html { redirect_to  course_topic_lesson_path(@course, @topic, @lesson), notice: 'Concept was successfully created.' }
         format.json { render :show, status: :ok, location: @model }
       else
         format.html { render :edit }
         format.json { render json: @model.errors, status: :unprocessable_entity }
       end
    end
  end

  def destroy
    @concept.lesson_concept.delete_all
    @concept.destroy
    respond_to do |format|
      format.html { redirect_to explanations_url, notice: 'Concept was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def set_concept
    @concept = Concept.find(:id)
  end

  def concept_params
    params.require(:concept).permit(:description, :lesson_id, :user_id)
  end
  def concept_update
    params.require(:concept).permit(:description)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
