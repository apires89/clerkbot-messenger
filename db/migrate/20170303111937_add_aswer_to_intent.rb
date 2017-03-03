class AddAswerToIntent < ActiveRecord::Migration[5.0]
  def change
    add_reference :intents, :answer, foreign_key: true
  end
end
