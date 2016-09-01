class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:destroy, :edit, :update, :show]
  
  def index
    @feedbacks = Feedback.all
  end

  def destroy
    
  end

  def show 
    
  end

  def edit
    
  end

  def update
    
  end

  def create
    rehearsal = Rehearsal.find(feedback_params[:rehearsal_id])
    feedback = rehearsal.feedbacks.build(feedback_params)
    respond_to do |format|
      if rehearsal.save
        format.html { redirect_to edit_feedback_path(feedback), notice: 'Begin feedback.' }
      else
        format.html { render :new }
        format.json { render json: @feeedback.errors, status: :unprocessable_entity }
      end
     end
  end

  private

  def set_rehearsal
    @rehearsal = Rehearsal.find(params[:id])
  end

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:user_id, :notes, :token, :video_token, :review_satatus, :concept_review, :video_type, :approved, :rehearsal_id)
  end
end
