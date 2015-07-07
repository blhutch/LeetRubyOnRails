class RemoveAirportIdFromFlight < ActiveRecord::Migration
  def change
    remove_column :flights, :airport_id, :string
  end
end
