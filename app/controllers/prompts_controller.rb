class PromptsController < ApplicationController
  before_action :set_lesson, only: [:new]
  before_action :set_prompt, only: [:show, :index]
  
  def new
    @prompt = Prompt.new
  end

  def create
    @lesson = current_user.lessons.build(params[:lesson_id])
    @lesson.prompts.build(prompt_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to [@lesson, @prompt], notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end

  end

  # def prompt_token
  #   prompt_token = token_params[:prompt]
  #   @lesson.prompt = prompt_token
  #
  #   if @lesson.save!
  #     render json: @lesson.prompt, status: :ok
  #   end
  # end

  private
  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_prompt
    @prompt = Prompt.find(params[:id])
  end

  def prompt_params
    params.require(:prompt).permit(:user_id, :lesson_id, :script, :token, :video_token)
  end
end
