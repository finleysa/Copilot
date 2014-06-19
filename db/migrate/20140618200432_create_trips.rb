
class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :lat_dest
      t.string :lng_dest
      t.string :lat_local
      t.string :lng:local
      t.datetime :date

      t.timestamps

    end
    add_index("users", "users_id")
  end
end
