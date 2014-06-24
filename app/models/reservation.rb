class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip

  def create

  end

  def new

  end
end
