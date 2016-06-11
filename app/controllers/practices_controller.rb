class PracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy, :submit]
  before_action :set_lesson
  before_action :authenticate_user!
  # GET /practices
  # GET /practices.json
  def index
    @practices = Practice.all
    # @practices = @lesson.practices.order("created_at ASC")
    # respond_to do |format|
    #   format.html { render layout: !request.xhr? }
    #   end
    # end
  end

  # GET /practices/1
  # GET /practices/1.json
  def show
  end

  # GET /practices/new
  def new
    @practice = current_user.practices.build
  end

  # GET /practices/1/edit
  def edit
  end

  # POST /practices
  # POST /practices.json

  def create
    @practice = @lesson.practices.build(practice_params)
    @practice.user_id = current_user.id
    if @practice.save
      respond_to do |format|
        # format.html { redirect_to root_path }
        format.html { redirect_to practices_path, notice: 'Practice was successfully created.' }
        format.json { render :show, status: :created, location: @practice }
        # format.js
      end
    else
      format.html { render :new }
      # flash[:alert] = "Check the practice form, something went wrong."
      format.json { render json: @practice.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /practices/1
  # PATCH/PUT /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to @practice, notice: 'Practice was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1
  # DELETE /practices/1.json
  def destroy
    @practice.destroy
    respond_to do |format|
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.json { head :no_content }
    end

    #
    #
    # if @practice.user_id == current_user.id
    #   @practice.delete
    #   respond_to do |format|
    #     format.html { redirect_to root_path }
    #     # format.js
    #   end
    # end


  end

  def submit
    binding.pry


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      # @practice = Practice.find(params[:id])
      @practice = @lesson.practices.find(params[:id])
    end

    def set_lesson
      @practice = Lesson.find(params[:lesson_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_params
      params.require(:practice).permit(:token, :video_token, :completed)
    end
end
