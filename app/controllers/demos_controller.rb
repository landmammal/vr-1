class DemosController < ApplicationController

	def index
		@all_demos = Demo.all.order(id: :desc)
		@site_title = 'Requested Demos'
	end

	def create
		new_demo = Demo.new(demo_params)
		new_demo.contacted = 'no'
		new_demo.completed = 'no'
		AdminMailer.lead_notice(new_demo).deliver_now!
		new_demo.save

		render json: new_demo	
	end



	private

	def demo_params
		params.permit(:first_name, :last_name, :phone_number, :email, :date)
	end
end
