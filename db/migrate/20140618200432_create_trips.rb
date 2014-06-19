
class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.timestamps

    end
    add_index("users", "users_id")
  end
end
