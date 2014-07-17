class AddStartingSeatsAvailableToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :starting_seats_available, :integer
  end
end
