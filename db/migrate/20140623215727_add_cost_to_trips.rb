class AddCostToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :cost, :string
  end
end
