class AddSelectionToFbUser < ActiveRecord::Migration[5.0]
  def change
    add_column :fb_users, :selection, :string
  end
end
