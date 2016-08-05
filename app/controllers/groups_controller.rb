class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @user_group = UserGroup.new
    @group_registration = GroupRegistration.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)

    respond_to do |format|
      if @group.save
        binding
        format.html { redirect_to user_groups_path(current_user), notice: 'group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @group.update
  end

  def destroy
    @group.destroy
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :privacy, :instructor_id)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
