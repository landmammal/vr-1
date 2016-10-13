class UserGroupsController < ApplicationController
  before_action :set_group, only: [:create]
  before_action :set_user_group, only: [:update ]

  def create
    @user_group = UserGroup.create(
                                  user_id: current_user.id,
                                  group_id: @group,
                                  user_role: current_user.role,
                                  approval_status: false
                                  )
    respond_to do |format|
      if @user_group.save
        format.js { flash.now[:notice] = "Your Registration has been sent" }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user_group.approval_status = true
    respond_to do |format|
      if @user_group.save
        format.js { flash.now[:notice] = "User approved" }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def set_user_group
    @user_group = UserGroup.find(params[:id])
  end

  def set_group
    @group = params[:group_id]
  end

  def register_params
    params.require(:user_group).permit(:group_id, :user_id, :user_role)
  end
end