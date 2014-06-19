
class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :starting_lat
      t.string :starting_lng
      t.string :ending_lat
      t.string :ending_lng
      t.datetime :date

      t.timestamps
    end
    add_index("users", "users_id")
  end
end
