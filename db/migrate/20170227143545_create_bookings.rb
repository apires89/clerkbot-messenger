class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.date :checkin
      t.date :checkout
      t.float :balance
      t.string :status
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
