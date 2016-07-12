class ModelsController < ApplicationController
  before_action :set_model, only: [:index]
  before_action :set_lesson, only: [new]

  def index

  end

  def new
    @model = Model.new
  end

  def create
    @lesson = current_user.lessons.build(params[:lesson_id])
    @lesson.models.build(model_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to [@lesson, @mode], notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end
  # def role_model_token
  #   role_model_token = token_params[:role_model]
  #   @lesson.role_model = role_model_token
  #
  #   if @lesson.save!
  #     render json: @lesson.role_model, status: :ok
  #   end
  # end
  private
  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_model
    @model = Model.find(params[:id])
  end

  def lesson_params
    params.require(:model).permit(:user_id, :lesson_id, :script, :token, :video_token)
  end
end
