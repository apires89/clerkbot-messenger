class AddUrlToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :url, :string
  end
end
