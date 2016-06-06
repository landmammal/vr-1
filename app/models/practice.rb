class Practice < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson


  def finished()

  end
end
