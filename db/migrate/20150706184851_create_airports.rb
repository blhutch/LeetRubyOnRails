class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :short_name
      t.string :city
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
