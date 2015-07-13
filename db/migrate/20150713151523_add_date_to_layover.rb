class AddDateToLayover < ActiveRecord::Migration
  def change
    add_column :layovers, :date, :datetime
  end
end
