class AddColumnsToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :location_start, :string
    add_column :trips, :location_end, :string
    add_column :trips, :time, :string
    add_column :trips, :vehicle, :string
    add_column :trips, :mpg, :string
    add_column :trips, :seats_available, :string
  end
end
