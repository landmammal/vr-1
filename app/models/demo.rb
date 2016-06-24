class Demo < ActiveRecord::Base

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	# validates_format_of :phone_number, :with => /[0-9]/i
	validates :date, presence: true

end
