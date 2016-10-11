class UserGroupsController < ApplicationController
  before_action :set_group, only: [:create]

  def create
    @user_group = UserGroup.create(user_id: current_user.id,
                                  group_id: @group,
                                  user_role: current_user.role,
                                  approval_status: false
                                  )
    binding.pry
    respond_to do |format|
      if @user_group.save
        format.html { redirect_to user_groups_path(current_user), notice: 'You successfully register to this group' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_group
    @group = params[:group_id]
  end

  def register_params
    params.require(:user_group).permit(:group_id, :user_id, :user_role)
  end
end
