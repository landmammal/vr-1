class Practice < ActiveRecord::Base
  belongs_to :user
  has_one :lessons
end
