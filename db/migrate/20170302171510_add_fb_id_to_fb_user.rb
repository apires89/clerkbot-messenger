class AddFbIdToFbUser < ActiveRecord::Migration[5.0]
  def change
    add_column :fb_users, :fb_id, :string
  end
end
