class AddSearchableToIntent < ActiveRecord::Migration[5.0]
  def change
    add_column :intents, :searchable, :bool, null: false, default: true
  end
end
