class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.datetime :departure_time
      t.integer :passenger_id
      t.string :destination
      t.string :departure_location
      t.string :confirmation_number
      t.string :url
      t.boolean :alert_sent , {:default => false}

      t.timestamps
    end
  end
end
