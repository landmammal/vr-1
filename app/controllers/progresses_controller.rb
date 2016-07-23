class ProgressesController < ApplicationController
  before_action :set_progress, only: [:edit, :update, :destroy]

  def index
    @progresses = Progress.all
  end

  def new
    @progress = Progress.new
  end

  def edit
  end

  def create


    respond_to do |format|
      if @progress.save
        format.html { redirect_to @progress, notice: 'Progress was successfully created.' }
        format.json { render :show, status: :created, location: @progress }
      else
        format.html { render :new }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @progress.update(progress_params)
        format.html { redirect_to @progress, notice: 'Progress was successfully updated.' }
        format.json { render :show, status: :ok, location: @progress }
      else
        format.html { render :edit }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @progress.destroy
    respond_to do |format|
      format.html { redirect_to progresses_url, notice: 'Progress was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_progress
      @progress = Progress.find(params[:id])
    end

    def progress_params
      params.require(:progress).permit(:lesson_id, :user_id, :explanation_id, :prompt_id, :model_id)
    end
end
