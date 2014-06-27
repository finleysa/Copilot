class AddStartingSeatsToUser < ActiveRecord::Migration
  def change
    add_column :users, :starting_seats_available, :integer
  end
end
