class GroupRegistrationsController < ApplicationController
  before_action :set_group, only: [:create]
  before_action :set_group_registration, only: [:edit, :update]

  def create
    @group.group_registrations.build(group_registration_params)

    respond_to do |format|
      if @group.save
        @group_registration = GroupRegistration.find(@group.group_registrations.last)
        binding.pry
        format.html { redirect_to edit_user_group_group_registration_path(current_user, @group, @group_registration),
                      notice: 'Choose the Course you want to register your group for.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @group = Group.find(params[:group_id])
  end

  def update
    respond_to do |format|
       if @group_registration.update(group_registration_params)
         binding.pry
         format.html { redirect_to course_topic_lesson_path(@course, @topic, @lesson), notice: 'Explanation was successfully updated.' }
         format.json { render :show, status: :ok, location: @explanation }
       else
         format.html { render :edit }
         format.json { render json: @explanation.errors, status: :unprocessable_entity }
       end
    end
  end
  private

  def set_group_registration
    @group_registration = GroupRegistration.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_registration][:group_id])
  end

  def group_registration_params
    params.require(:group_registration).permit(:course_id, :group_id)
  end
end
