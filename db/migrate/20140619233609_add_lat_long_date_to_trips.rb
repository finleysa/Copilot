class AddLatLongDateToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :lat_dest, :string
    add_column :trips, :lng_dest, :string
    add_column :trips, :lat_local, :string
    add_column :trips, :lng_local, :string
    add_column :trips, :date, :datetime
  end
end
