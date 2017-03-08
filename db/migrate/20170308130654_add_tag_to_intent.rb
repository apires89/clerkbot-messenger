class AddTagToIntent < ActiveRecord::Migration[5.0]
  def change
    add_column :intents, :tag, :string
  end
end
