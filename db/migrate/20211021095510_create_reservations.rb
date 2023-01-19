class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :date
      t.time :time
      t.belongs_to :customer, foreign_key: true
      t.belongs_to :vehicle, foreign_key: true
      t.timestamps
    end
  end
end
