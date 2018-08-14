class DemosController < ApplicationController
	before_action :authenticate_user! , only: [:index]

	def index
		current_user.level_1 ? @all_demos = Demo.all.order(id: :desc) : @all_demos = []
		@site_title = 'Requested Demos'
	end

	def create
		@new_demo = Demo.new(demo_params)
		@new_demo.contacted = 'no'
		@new_demo.completed = 'no'
		# @new_demo.save
		# render json: @new_demo

		formFilled = true

		if params[:first_name] == ''
			formFilled = false
			err_message = 'first name'
		end
		if params[:last_name] == ''
			formFilled = false
			err_message = 'last name'
		end
		if params[:email] == ''
			formFilled = false
			err_message = 'email'
		end

		respond_to do |format|
	      if formFilled
	      	if @new_demo.save
		    	@checksent_demo = 'sent'
				AdminMailer.lead_notice(@new_demo).deliver_later!
		        format.js { }
		    end
	      else
	      	@checksent_demo = 'not_sent'
	      	@err = 'The '+ err_message +' field has not been filled in.'
	        format.js { }
	      end
	    end
	end



	private

	def demo_params
		params.require(:demo).permit(:first_name, :last_name, :phone_number, :email, :date, :messagecontent)
	end
end
