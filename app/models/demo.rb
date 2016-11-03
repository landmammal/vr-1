class Demo < ApplicationRecord

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	# validates :date, presence: true

end
