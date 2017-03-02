class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :fb_message_id
      t.string :message_type
      t.datetime :sent_at

      t.timestamps
    end
  end
end
