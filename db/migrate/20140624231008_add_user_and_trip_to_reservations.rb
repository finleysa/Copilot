class AddUserAndTripToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :user_id, :integer
    add_column :reservations, :trip_id, :integer
  end
end
