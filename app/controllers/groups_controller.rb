class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :destroy]

  def all_groups
    @groups = Group.all
    @my_groups = current_user.groups.all
    @user_group = UserGroup.new
  end

  def index
    @groups = current_user.groups.all
  end

  def show
    @user_group = UserGroup.new
    @group_registration = GroupRegistration.new
    @users_in_group = []
    @group.user_groups.each { |ug| @users_in_group << ug.user }

    respond_to do |format|
        format.js {  }
    end
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
