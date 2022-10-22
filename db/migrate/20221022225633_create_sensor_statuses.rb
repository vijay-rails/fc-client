class CreateSensorStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :sensor_statuses do |t|
      t.references :sensor, null: false, foreign_key: true
      t.integer :status
      t.datetime :transmitted_at
      t.timestamps
    end
  end
end