class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip

  attr_accessible :user_id, :trip_id

  def create

  end

  def new

  end
end
