class CreateIntents < ActiveRecord::Migration[5.0]
  def change
    create_table :intents do |t|
      t.references :intent, foreign_key: true
      t.string :q_string
      t.string :q_key

      t.timestamps
    end
  end
end
