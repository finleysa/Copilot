class CreateTripsUsersJoin < ActiveRecord::Migration
  def change
    create_table :trips_users, :id => false do |t|
      t.integer "trip_id"
      t.integer "user_id"
    end
    add_index :trips_users, ["trip_id", "user_id"]
  end
end
