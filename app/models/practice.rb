class Practice < ActiveRecord::Base
  belongs_to :user
  has_one :lesson


  def finished()

  end
end
