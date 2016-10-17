class GroupRegistrationsController < ApplicationController
  before_action :set_group, only: [:new]
  before_action :set_group_registration, only: [:edit, :update]

  # a shadow box for user to all the groups he can register to and register to them
  def registrations
    @group_registration = GroupRegistration.new
    @courses = Course.all
    @group = Group.find(params[:id])
    instructor = @group.instructor
    @my_courses = instructor.courses
    respond_to do |format|
      format.js {  }
    end
  end

  def new
  end

  def create
    course = Course.find(params.values[1][:course_id])
    group = Group.find(params[:id])
    group_registration = GroupRegistration.create(
                                              course_id: course.id,
                                              group_id: group.id,
                                              approval_status: false

    )
    respond_to do |format|
      if group_registration.save!
        format.js { flash.now[:notice] = "Your Registration has been sent" }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @courses = current_user.courses.all
  end

  def update

    respond_to do |format|
       if @group_registration.update(group_registration_params)

          @group = Group.find(params[:group_id])
            binding.pry
         format.html { redirect_to user_groups_path(current_user, @group), notice: 'Group was successfully register.' }
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
