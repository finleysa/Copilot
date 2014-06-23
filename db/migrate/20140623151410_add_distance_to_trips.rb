class AddDistanceToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :distance, :string
  end
end
