class CreateSensors < ActiveRecord::Migration[6.0]
  def change
    create_table :sensors do |t|
      t.decimal :temperature, precision: 5, scale: 2, null: false
      t.timestamps
    end
  end
end
