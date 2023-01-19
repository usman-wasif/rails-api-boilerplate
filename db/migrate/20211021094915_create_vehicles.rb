class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :cms_vehicle_id
      t.string :model
      t.string :make
    end
  end
end
