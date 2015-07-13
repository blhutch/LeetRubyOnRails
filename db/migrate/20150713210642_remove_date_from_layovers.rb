class RemoveDateFromLayovers < ActiveRecord::Migration
  def change
    remove_column :layovers, :date, :datetime
  end
end
