class RemoveIndexFromFlight < ActiveRecord::Migration
  def change
    remove_index :flights, :flight_id
  end
end
