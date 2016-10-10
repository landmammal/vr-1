class UserGroupsController < ApplicationController
  before_action :set_group, only: [:create]

  def create
    binding.pry
    @group.user_groups.build(register_params)
    binding.pry
    respond_to do |format|
      if @group.save
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
    @group = Group.find(params[:user_group][:group_id])
  end

  def register_params
    params.require(:user_group).permit(:group_id, :user_id, :user_role)
  end
end
