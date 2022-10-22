class CreateSpaceShips < ActiveRecord::Migration[6.0]
  def change
    create_table :space_ships do |t|

      t.timestamps
    end
  end
end
