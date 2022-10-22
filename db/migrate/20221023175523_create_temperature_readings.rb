class CreateTemperatureReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :temperature_readings do |t|
      t.decimal :temperature, precision: 5, scale: 2, null: false
      t.datetime :measured_at, limit: 3
      t.timestamps
    end
    add_index :temperature_readings, :measured_at, unique: true
  end
end
