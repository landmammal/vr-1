class ModelsController < ApplicationController
  def role_model_token
    role_model_token = token_params[:role_model]
    @lesson.role_model = role_model_token

    if @lesson.save!
      render json: @lesson.role_model, status: :ok
    end
  end
end
